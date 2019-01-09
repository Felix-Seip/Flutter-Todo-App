import 'todo.dart';

class Folder {
  String _title;
  List<Todo> _todos;

  Folder(this._title, this._todos);

  String getTitle(){
    return _title;
  }

  Todo getTodo(int index){
    return _todos[index];
  }

  List<Todo> getAllTodos(){
    return _todos;
  }

  void addTodo(Todo todo){
    _todos.add(todo);
  }

  void deleteTodo(Todo todo){
    _todos.remove(todo);
  }
}
