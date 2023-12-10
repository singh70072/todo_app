import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/widgets/todo_items.dart';

import 'model/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final todosList = ToDo.todoList();
  final  todoController = TextEditingController();
  List<ToDo> foundToDo= [];
  @override
  void initState() {
    foundToDo = todosList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.grey,
      appBar:_buildAppBar() ,

      body:Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child:Column(
                children: [
                  searchBox(),
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text('All ToDos',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
                      ),
                      for (ToDo todoo in foundToDo.reversed)
                        ToDoItems(
                          todo: todoo,
                          onToDoChanged: handleToDoChange,
                          onDeleteItem: deleteToDoItems,
                        ),

                    ],
                  ))

                ],
              ) ,
            ),
          ),

          Align(alignment: Alignment.bottomCenter,
          child:Row(
            children: [
              Expanded(child:
              Container(margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.grey,
    offset: Offset(0.0,0.0),
    blurRadius: 10.0,
    spreadRadius: 0.0,)],
                  borderRadius: BorderRadius.circular(10),
                  ),
                child: TextField(

                  controller: todoController,
                  decoration: InputDecoration(
                    hintText: 'Add a New todo item',
                    border: InputBorder.none,


                  ),
                ),
                ),

              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  onPressed: (){
                    addToDoItem(todoController.text);
                  },
                  child:  Text('+', style: TextStyle(fontSize: 40),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 10
                  ),
                ),
              )
            ],
          ) ,
          ),
        ],
      ),
    );
  }
  void handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
  void deleteToDoItems(String id){
    setState(() {
      todosList.removeWhere((item) => item.id == id );
    });

  }
  void addToDoItem(String todo){
    setState(() {
      todosList.add(ToDo(id: DateTime.now().microsecondsSinceEpoch.toString(), todoText:todo,));
    });
    todoController.clear();

  }
  void runFilter(String enterKeyword){
    List<ToDo>? results = [];
    if(enterKeyword.isEmpty){
      results = todosList;
    }else{
      results = todosList.where((item) => item.todoText!.toLowerCase().contains(enterKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundToDo = results!;
    });
  }
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor:Colors.white,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: Colors.black,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/pic2.png'),
          ),
        ),
      ]),
    );
  }
  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }




  }
