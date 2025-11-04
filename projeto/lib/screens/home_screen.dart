import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../models/todo_model.dart';
import '../bloc/theme_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List - Flutter + BLoC'),
        actions: [
          // Botão de tema
          IconButton(
            icon: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return Icon(
                  state.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
                );
              },
            ),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleTheme());
            },
            tooltip: 'Alternar Tema',
          ),
          // Widget para o Filtro
          _buildFilterMenu(context),
        ],
      ),
      // O BlocBuilder reconstrói a UI quando o TodoState muda
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          // Usamos o getter filteredTodos que criamos no estado!
          final todos = state.filteredTodos;

          if (todos.isEmpty) {
            return const Center(child: Text('Nenhuma tarefa encontrada.'));
          }

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return _buildTodoTile(context, todo);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Passa null, pois é uma nova tarefa
          _showTodoDialog(context, null);
        },
      ),
    );
  }

  // Popup de Filtro
  Widget _buildFilterMenu(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return PopupMenuButton<TodoFilter>(
          initialValue: state.filter,
          onSelected: (filter) {
            // Dispara o evento para mudar o filtro
            context.read<TodoBloc>().add(ChangeFilter(filter: filter));
          },
          icon: const Icon(Icons.filter_list),
          itemBuilder: (context) => [
            const PopupMenuItem(value: TodoFilter.all, child: Text('Todas')),
            const PopupMenuItem(
              value: TodoFilter.pending,
              child: Text('Pendentes'),
            ),
            const PopupMenuItem(
              value: TodoFilter.completed,
              child: Text('Concluídas'),
            ),
          ],
        );
      },
    );
  }

  // O Card de cada Tarefa
  Widget _buildTodoTile(BuildContext context, Todo todo) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        // Marcar como concluído
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (bool? newValue) {
            if (newValue != null) {
              // Dispara o evento de atualização
              context.read<TodoBloc>().add(
                UpdateTodo(todo: todo.copyWith(isCompleted: newValue)),
              );
            }
          },
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: todo.observation.isNotEmpty ? Text(todo.observation) : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Botão de Editar
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () {
                _showTodoDialog(context, todo);
              },
            ),
            // Botão de Excluir
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                // Dispara o evento de exclusão
                context.read<TodoBloc>().add(DeleteTodo(todo: todo));
              },
            ),
          ],
        ),
      ),
    );
  }

  // Diálogo para Adicionar ou Editar Tarefa
  void _showTodoDialog(BuildContext context, Todo? todoToEdit) {
    final titleController = TextEditingController(
      text: todoToEdit?.title ?? '',
    );
    final observationController = TextEditingController(
      text: todoToEdit?.observation ?? '',
    );

    // Pega uma referência do BLoC *antes* do 'await'
    final todoBloc = context.read<TodoBloc>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(todoToEdit == null ? 'Nova Tarefa' : 'Editar Tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                autofocus: true,
              ),
              TextField(
                controller: observationController,
                decoration: const InputDecoration(labelText: 'Observação'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: const Text('Salvar'),
              onPressed: () {
                final title = titleController.text;
                if (title.isEmpty)
                  return; // Não salva se o título estiver vazio

                if (todoToEdit == null) {
                  // ADICIONAR
                  todoBloc.add(
                    AddTodo(
                      title: title,
                      observation: observationController.text,
                    ),
                  );
                } else {
                  // EDITAR
                  todoBloc.add(
                    UpdateTodo(
                      todo: todoToEdit.copyWith(
                        title: title,
                        observation: observationController.text,
                      ),
                    ),
                  );
                }
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
