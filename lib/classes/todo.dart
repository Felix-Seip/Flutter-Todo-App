class Todo {
  String _title;
  DateTime _completionDate;
  String _additionalNotes; 
  
  Todo(this._title, this._completionDate, this._additionalNotes);

  String getTitle(){
    return _title;
  }

  DateTime getCompletionTime(){
    return _completionDate;
  }

  String getAdditionalNotes(){
    return _additionalNotes;
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
}