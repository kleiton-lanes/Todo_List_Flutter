part of 'todo_bloc.dart';

// Enum para definir os tipos de filtro disponíveis
enum TodoFilter { all, pending, completed }

// Classe base para todos os eventos
// Equatable ajuda na comparação de eventos
abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

// Evento para carregar as tarefas iniciais
class LoadTodos extends TodoEvent {}

// Evento para adicionar uma nova tarefa
class AddTodo extends TodoEvent {
  final String title;
  final String observation;

  const AddTodo({required this.title, required this.observation});

  @override
  List<Object> get props => [title, observation];
}

// Evento para atualizar uma tarefa existente
class UpdateTodo extends TodoEvent {
  final Todo todo;

  const UpdateTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

// Evento para excluir uma tarefa
class DeleteTodo extends TodoEvent {
  final Todo todo;

  const DeleteTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

// Evento para mudar o filtro atual
class ChangeFilter extends TodoEvent {
  final TodoFilter filter;

  const ChangeFilter({required this.filter});

  @override
  List<Object> get props => [filter];
}
