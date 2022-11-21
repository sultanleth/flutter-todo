import 'package:todo/models/todo.dart';
import 'package:todo/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoRepository implements Repository {
  String dataURL = 'https://jsonplaceholder.typicode.com';

  @override
  Future<List<Todo>> getTodoList() async {
    List<Todo> todoList = [];
    var url = Uri.parse('$dataURL/todos');
    var response = await http.get(url);
    var body = json.decode(response.body);
    for (var i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[i]));
    }
    return todoList;
  }

  @override
  Future<String> postTodo(Todo todo) async {
    var url = Uri.parse('$dataURL/todos/');
    String result = '';
    await http.post(url, body: todo.toJson());
    return 'Posted successfully';
  }

  @override
  Future<String> patchCompleted(Todo todo) async {
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    String resData = '';
    await http.patch(
      url,
      body: {
        'completed': (!todo.completed).toString(),
      },
      headers: {'Authorization': 'your_token'},
    ).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      //result['completed']
      return resData = "Patched successfully";
    });
    return resData;
  }

  @override
  Future<String> putCompleted(Todo todo) async {
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    String resData = '';
    await http.put(
      url,
      body: {
        'completed': (!todo.completed).toString(),
      },
      headers: {'Authorization': 'your_token'},
    ).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      //result['completed']
      return resData = "Put successfully";
    });
    return resData;
  }

  @override
  Future<String> deleteTodo(Todo todo) async {
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    String result = 'false';
    await http.delete(url).then((response) {
      return result = 'Deleted successfully';
    });
    return result;
  }
}
