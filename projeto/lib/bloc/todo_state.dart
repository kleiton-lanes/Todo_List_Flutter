part of 'todo_bloc.dart';

// Classe que representa o estado atual do aplicativo
class TodoState extends Equatable {
  final List<Todo> allTodos; // Lista com todas as tarefas
  final TodoFilter filter; // Filtro atual

  const TodoState({
    this.allTodos = const <Todo>[], // Começa com lista vazia
    this.filter = TodoFilter.all, // Filtro inicial mostra tudo
  });

  // Getter que retorna as tarefas filtradas
  // É recalculado automaticamente quando o estado muda
  List<Todo> get filteredTodos {
    switch (filter) {
      case TodoFilter.completed:
        return allTodos.where((todo) => todo.isCompleted).toList();
      case TodoFilter.pending:
        return allTodos.where((todo) => !todo.isCompleted).toList();
      case TodoFilter.all:
        return allTodos;
    }
  }

  // Método para criar uma cópia do estado com algumas modificações
  TodoState copyWith({List<Todo>? allTodos, TodoFilter? filter}) {
    return TodoState(
      allTodos: allTodos ?? this.allTodos,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [allTodos, filter];
}
