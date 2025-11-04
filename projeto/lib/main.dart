import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/todo_bloc.dart';
import 'bloc/theme_bloc.dart';
import 'screens/home_screen.dart';

// Ponto de entrada do aplicativo
void main() {
  runApp(const MyApp());
}

// Widget raiz do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { // Método build: constrói a árvore de widgets e recebe o BuildContext
    return MultiBlocProvider( // Fornece múltiplos BLoCs para a subárvore de widgets
      providers: [ // Lista de BlocProviders que serão acessíveis pelos widgets filhos
        BlocProvider(create: (context) => TodoBloc()..add(LoadTodos())), // Cria e fornece o TodoBloc; o '..add(LoadTodos())' dispara um evento para inicializar/ carregar tarefas
        BlocProvider(create: (context) => ThemeBloc()), // Cria e fornece o ThemeBloc para controlar tema claro/escuro
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Flutter BLoC ToDo',
            // Configuração do tema do aplicativo
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true, // Usa o Material Design 3
              brightness: themeState.isDarkTheme
                  ? Brightness.dark
                  : Brightness.light,
            ),
            home: const HomeScreen(), // Tela inicial
          );
        },
      ),
    );
  }
}