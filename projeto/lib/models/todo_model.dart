import 'package:equatable/equatable.dart';

// Esta classe representa uma tarefa (Todo)
// Extends Equatable para facilitar comparações de objetos
class Todo extends Equatable {
  // Propriedades básicas de uma tarefa
  final String id; // Identificador único da tarefa
  final String title; // Título da tarefa
  final String observation; // Observação/descrição opcional
  final bool isCompleted; // Status de conclusão

  // Construtor com parâmetros nomeados
  // O 'required' significa que o parâmetro é obrigatório
  const Todo({
    required this.id,
    required this.title,
    this.observation = '', // Valor padrão vazio
    this.isCompleted = false, // Por padrão, tarefa não está concluída
  });

  // Método copyWith - muito importante para imutabilidade
  // Permite criar uma cópia do objeto alterando apenas alguns campos
  Todo copyWith({
    String? id,
    String? title,
    String? observation,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id, // Se não fornecido, mantém o valor atual
      title: title ?? this.title,
      observation: observation ?? this.observation,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Implementação necessária do Equatable
  // Define quais campos serão usados para comparar objetos
  @override
  List<Object?> get props => [id, title, observation, isCompleted];
}
