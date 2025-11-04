import 'package:flutter_bloc/flutter_bloc.dart';

// Eventos do tema
abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

// Estado do tema
class ThemeState {
  final bool isDarkTheme;

  ThemeState({this.isDarkTheme = true});
}

// BLoC do tema
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState()) {
    on<ToggleTheme>((event, emit) {
      emit(ThemeState(isDarkTheme: !state.isDarkTheme));
    });
  }
}
