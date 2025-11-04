import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final SharedPreferences sharedPreferences;
  final String _key = 'todos';

  TodoRepositoryImpl(this.sharedPreferences);

  @override
  Future<List<TodoEntity>> getTodos() async {
    final String? jsonString = sharedPreferences.getString(_key);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => TodoModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<TodoEntity> getTodoById(String id) async {
    final todos = await getTodos();
    final todo = todos.firstWhere((todo) => todo.id == id);
    return todo;
  }

  @override
  Future<void> addTodo(TodoEntity todo) async {
    final todos = await getTodos();
    final todoModel = TodoModel.fromEntity(todo);
    todos.add(todoModel);
    await _saveTodos(todos);
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    final todos = await getTodos();
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index >= 0) {
      todos[index] = TodoModel.fromEntity(todo);
      await _saveTodos(todos);
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await getTodos();
    todos.removeWhere((todo) => todo.id == id);
    await _saveTodos(todos);
  }

  @override
  Future<void> toggleTodoStatus(String id) async {
    final todos = await getTodos();
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index >= 0) {
      final todo = todos[index];
      todos[index] = TodoModel.fromEntity(
        todo.copyWith(isCompleted: !todo.isCompleted),
      );
      await _saveTodos(todos);
    }
  }

  Future<void> _saveTodos(List<TodoEntity> todos) async {
    final List<Map<String, dynamic>> jsonList = todos
        .map((todo) => (todo as TodoModel).toJson())
        .toList();
    await sharedPreferences.setString(_key, json.encode(jsonList));
  }
}
