# Todo List Flutter (BLoC)

Resumo do projeto Todo List em Flutter usando BLoC.

## Funcionalidades
- Adicionar tarefa com título e observação.
- Marcar tarefa como concluída/pendente.
- Editar tarefa.
- Excluir tarefa.
- Filtrar tarefas: todas, pendentes, concluídas.
- Alternar tema claro/escuro (ThemeBloc).

## Arquitetura
- Padrão BLoC (flutter_bloc):
  - Events: eventos que descrevem ações (ex.: AddTodo, UpdateTodo).
  - States: estado da aplicação (ex.: TodoState com allTodos e filter).
  - Bloc: lógica de negócio em `TodoBloc` que recebe eventos e emite estados.
- Segue princípios de Clean Architecture (separação UI / lógica / dados).
- Injeção de blocos com `MultiBlocProvider` em `main.dart`.

## Estrutura principal (resumida)
- lib/
  - bloc/
    - todo_bloc.dart
    - todo_event.dart
    - todo_state.dart
    - theme_bloc.dart
  - models/
    - todo_model.dart
  - screens/
    - home_screen.dart
  - main.dart

## Como executar
1. Abra o terminal no diretório do projeto:
   - Windows (PowerShell/Terminal do VSCode):
     cd "k:\Faculdade_Backup\Programacao para dispositivos moveis\Flutter\Todo_List\projeto"
2. Instale dependências:
   flutter pub get
3. Rode o app:
   flutter run

## Observações para iniciantes
- A UI dispara eventos ao BLoC (ex.: `context.read<TodoBloc>().add(AddTodo(...))`).
- Use `BlocBuilder<TodoBloc, TodoState>` para reconstruir widgets quando o estado mudar.
- Para alternar tema, o projeto usa `ThemeBloc` e `BlocBuilder<ThemeBloc, ThemeState>` em `main.dart`.
- Verifique o modelo `Todo` (imutabilidade com `copyWith`) antes de atualizar itens.

## Dicas de estudo
- Leia sobre `flutter_bloc` e o padrão BLoC para entender fluxo UI → Eventos → BLoC → Estados → UI.
- Experimente adicionar persistência local (ex.: shared_preferences ou sqflite) para salvar tarefas.
- Crie testes unitários para os handlers do `TodoBloc` (`_onAddTodo`, `_onUpdateTodo`, etc.).

---
Arquivo criado para te ajudar a entender e continuar o projeto. Se quiser, gero um arquivo CONTRIBUTING.md ou adiciono instruções de testes.
