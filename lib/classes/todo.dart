class Todo {
  String _title;
  DateTime _completionDate;
  String _additionalNotes; 
  
  Todo(this._title, this._completionDate, this._additionalNotes);

  String getTitle(){
    return _title;
  }
}