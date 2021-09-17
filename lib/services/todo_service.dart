import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/repositories/repository.dart';

class TodoService{
  Repository _repository;
  TodoService(){
    _repository = Repository();
  }
  insertTodo(Todo todo) async{
    return await _repository.save("todos", todo.todoMap());
  }

  getTodos() async{
    return await _repository.getAll("todos");
  }

  todosByCategory(String category) async{
    return await _repository.getByColumnName("todos", "category", category);
  }
  deleteTodo(todoId) async {
    return await _repository.delete('todos', todoId);
  }
}