import 'package:flutter/material.dart';
import 'package:todo/controller/todo_controller.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/repository/todo_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todoController = TodoController(TodoRepository());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.bold
        ),
        leading: const Icon(Icons.list_alt_rounded, color: Colors.white),
      ),
      body: FutureBuilder(
          future: todoController.fetchTodoList(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }

            return buildBodyContent(snapshot, todoController);
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Todo newtodo =
              Todo(userId: 3, title: 'sample post', completed: false);
          todoController.postTodo(newtodo).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(value),
              duration: const Duration(milliseconds: 2000),
            ));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  SafeArea buildBodyContent(
      AsyncSnapshot<List<Todo>> snapshot, TodoController todoController) {
    return SafeArea(
      child: ListView.separated(
          itemBuilder: (context, index) {
            var todo = snapshot.data[index];
            return Container(
              height: 100.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Text('${todo.id}'),
                ),
                Expanded(
                  flex: 3,
                  child: Text(todo.title),
                ),
                Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: () {
                              todoController
                                  .updatePatchCompleted(todo)
                                  .then((value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(value),
                                  duration: const Duration(milliseconds: 2000),
                                ));
                              });
                            },
                            child: buildCallContainer(
                                'Patch', const Color(0xFFFFE0B2))),
                        InkWell(
                            onTap: () {
                              todoController
                                  .updatePutCompleted(todo)
                                  .then((value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(value),
                                  duration: const Duration(milliseconds: 2000),
                                ));
                              });
                            },
                            child: buildCallContainer(
                                'Put', const Color(0xFFE1BEE7))),
                        InkWell(
                            onTap: () {
                              todoController.deleteTodo(todo).then((value) => {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(value),
                                            duration: const Duration(
                                                milliseconds: 2000))),
                                  });
                            },
                            child: buildCallContainer(
                                'Del', const Color(0xFFFFCDD2)))
                      ],
                    ))
              ]),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 0.5,
              height: 0.5,
            );
          },
          itemCount: snapshot.data.length ?? 0),
    );
  }
}

Container buildCallContainer(String title, Color color) {
  return Container(
    width: 40.0,
    height: 40.0,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(10.0)),
    child: Center(child: Text(title)),
  );
}
