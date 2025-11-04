import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart'; // Importe o uuid
import '../models/todo_model.dart'; // Importe o modelo

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Uuid _uuid = const Uuid(); // Gerador de ID

  TodoBloc() : super(const TodoState()) {
    // Define o que fazer para cada evento
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<ChangeFilter>(_onChangeFilter);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) {
    // Por enquanto, só emitimos um estado vazio.
    // No futuro, aqui você carregaria do banco de dados.
    emit(const TodoState(allTodos: [], filter: TodoFilter.all));
  }

  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) {
    final newTodo = Todo(
      id: _uuid.v4(), // Gera um ID único
      title: event.title,
      observation: event.observation,
    );
    
    // Cria uma NOVA lista baseada no estado anterior + o novo item
    final updatedList = List<Todo>.from(state.allTodos)..add(newTodo);
    
    emit(state.copyWith(allTodos: updatedList));
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) {
    final updatedList = state.allTodos.map((todo) {
      // Se o ID for o mesmo, retorna a tarefa atualizada, senão, retorna a antiga
      return todo.id == event.todo.id ? event.todo : todo;
    }).toList();

    emit(state.copyWith(allTodos: updatedList));
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) {
    // Cria uma NOVA lista, removendo o item
    final updatedList = state.allTodos.where((todo) {
      return todo.id != event.todo.id;
    }).toList();

    emit(state.copyWith(allTodos: updatedList));
  }

  void _onChangeFilter(ChangeFilter event, Emitter<TodoState> emit) {
    // Apenas muda o filtro no estado
    emit(state.copyWith(filter: event.filter));
  }
}