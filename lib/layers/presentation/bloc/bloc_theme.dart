import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc()
      : super(ThemeData.light()) {
    on<ThemeEvent>((event, emit) {
      if (state.brightness == Brightness.light) {
        emit(ThemeData.dark());
      } else {
        emit(ThemeData.light());
      }
    });
  }
}