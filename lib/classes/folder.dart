import 'todo.dart';

class Folder {
  String _title;
  String _imagePath;
  List<Todo> _todos;

  Folder(this._title, this._todos, this._imagePath);

  String getTitle(){
    return _title;
  }

  String getImagePath(){
    return _imagePath;
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
