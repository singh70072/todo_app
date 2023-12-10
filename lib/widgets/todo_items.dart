import 'package:flutter/material.dart';

import '../model/todo.dart';

class ToDoItems extends StatelessWidget{
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItems({super.key, required this.todo, this.onToDoChanged, this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
   return Container(
     margin: const EdgeInsets. only(bottom: 20),
     child: ListTile(
       onTap: (){
        // print ('clicked on ToDo item')
         onToDoChanged(todo);
       },
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
       contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
       tileColor: Colors.white,
       leading: Icon( todo.isDone? Icons.check_box: Icons.check_box_outline_blank,
         color: Colors.blue,),
       title:  Text(todo.todoText!,
         style: TextStyle(fontSize: 16,
           color: Colors.black,
           decoration:todo.isDone? TextDecoration.lineThrough: null),),
       trailing: Container(
         padding: EdgeInsets.all(0),
         margin: EdgeInsets.symmetric(vertical: 12),
         height: 35,
         width: 35,
         decoration: BoxDecoration(
           color: Colors.red,
           borderRadius: BorderRadius.circular(5),
         ),
         child: IconButton(
           color: Colors.white,
           iconSize: 18,
           icon:Icon(Icons.delete),
           onPressed: (){
             //print('Clicked on Delete icon');
             onDeleteItem(todo.id);

           },
         ),
       ),
     ),
   );
  }
}