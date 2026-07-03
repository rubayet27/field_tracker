import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const _themeKey = 'theme_mode';

  ThemeBloc() : super(const ThemeState()) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<SetThemeEvent>(_onSetTheme);
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false;
    add(SetThemeEvent(isDark ? ThemeMode.dark : ThemeMode.light));
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final newMode = state.isDark ? ThemeMode.light : ThemeMode.dark;
    await _saveTheme(newMode);
    emit(state.copyWith(themeMode: newMode));
  }

  Future<void> _onSetTheme(
    SetThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    await _saveTheme(event.themeMode);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, mode == ThemeMode.dark);
  }
}