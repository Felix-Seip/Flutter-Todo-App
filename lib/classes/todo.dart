import '../classes/folder.dart';
import '../classes/enums.dart';

class Todo {
  String _title;
  DateTime _completionDate;
  String _additionalNotes; 
  Folder _parentFolder;
  TodoStatus todoStatus;
  
  Todo(this._title, this._completionDate, this._additionalNotes, this._parentFolder, {this.todoStatus = TodoStatus.Uncomplete});

  String getTitle(){
    return _title;
  }

  DateTime getCompletionTime(){
    return _completionDate;
  }

  String getAdditionalNotes(){
    return _additionalNotes;
  }

  TodoStatus getStatus(){
    return todoStatus;
  }

  Folder getParentFolder(){
    return _parentFolder;
  }

  void setTitle(String title){
    _title = title;
  }

  void setCompletionTime(DateTime completionDate){
    _completionDate = completionDate;
  }

  void setAdditionalNotes(String addtionalNotes){
    _additionalNotes = addtionalNotes;
  }

  void setTodoStatus(TodoStatus status){
    todoStatus = status;
  }
}