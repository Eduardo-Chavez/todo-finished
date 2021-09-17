import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/services/todo_service.dart';

class TodosByCategory extends StatefulWidget {
  final String category;
  TodosByCategory({this.category});
  @override
  _TodosByCategoryState createState() => _TodosByCategoryState();
}

class _TodosByCategoryState extends State<TodosByCategory> {
  List<Todo> _todoList = List<Todo>.empty(growable: true);
  TodoService _todoService = TodoService();


  getTodosByCategory() async{
    var todos = await _todoService.todosByCategory(this.widget.category);
    todos.forEach(
        (todo){
          setState(() {
            var model = Todo();
            model.id = todo["id"];
            model.title = todo["title"];
            _todoList.add(model);
          });
        }
    );
  }

  @override
  void initState() {
    super.initState();
    getTodosByCategory();
  }


    _showSnackBar(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  _deleteToDoDialog(BuildContext context, todoId) { //Dialogo para borrar un elemento
    return showDialog(context: context, barrierDismissible: true, builder: (param) {
          return AlertDialog( // Se genera a partir de sus partes
            actions: <Widget>[ElevatedButton(
                style: ElevatedButton.styleFrom( // Se coloca estilo para mejorar la experiencia
                  primary: Colors.green, // background
                  onPrimary: Colors.white, // foreground
                ), onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ), ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.white, // foreground
                ), onPressed: () async { // Al presionar borrar se eliminara el registro
                  var result =
                  await _todoService. deleteTodo(todoId);
                  if (result > 0) { // Permitirá actualizar la lista con el cambio realizado
                    Navigator.pop(context);
                    
                    getTodosByCategory();
                    _showSnackBar('Deleted!');
                  }}, child: Text('Delete'),
              ),
            ],
            title: Text("Are you sure you want to delete?"),);
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos by category"),
      ),
      body: Column(
        children: <Widget>[
          Text(this.widget.category),
          Expanded(child:
          ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_todoList[index].title ?? "No title"),
                         IconButton(
                      icon: Icon(Icons.delete), 
                      onPressed: (){
                        _deleteToDoDialog( context, _todoList[index].id);
                      })
                      ],
                    ),
                  ),
                );
              }),
          ),
        ],
      ),

    );
  }
}
