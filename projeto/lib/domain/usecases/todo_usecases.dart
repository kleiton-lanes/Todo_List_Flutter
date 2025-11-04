import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class GetTodosUseCase {
  final TodoRepository repository;

  GetTodosUseCase(this.repository);

  Future<List<TodoEntity>> call() async {
    return await repository.getTodos();
  }
}

class AddTodoUseCase {
  final TodoRepository repository;

  AddTodoUseCase(this.repository);

  Future<void> call(TodoEntity todo) async {
    await repository.addTodo(todo);
  }
}

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  Future<void> call(TodoEntity todo) async {
    await repository.updateTodo(todo);
  }
}

class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.deleteTodo(id);
  }
}

class ToggleTodoStatusUseCase {
  final TodoRepository repository;

  ToggleTodoStatusUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.toggleTodoStatus(id);
  }
}
