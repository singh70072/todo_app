class ToDo{
  String?id;
  String?todoText;
  late bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false

  });
  static List<ToDo> todoList(){
    return [
      ToDo(id: '01', todoText:'Morning Exercise', isDone: true),
      ToDo(id: '02', todoText:'Read NewsPaper', isDone: true),
      ToDo(id: '03', todoText:'Check Emails'),
      ToDo(id: '04', todoText:'Buy Groceries'),
      ToDo(id: '05', todoText:'Team Meeting'),
      ToDo(id: '06', todoText:'Family time'),
      ToDo(id: '07', todoText:'Cycling'),
      ToDo(id: '08', todoText:'Reading book'),
      ToDo(id: '09', todoText:'code for 2 hrs'),
      ToDo(id: '10', todoText:'dinner'),
      ToDo(id: '11', todoText:'Back Check'),
      ToDo(id: '12', todoText:'Tomorrow Plan'),
      ToDo(id: '13', todoText:'milk time'),
      ToDo(id: '14', todoText:'Setting Alarm'),


    ];
  }

}
