import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_bloc.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_event.dart';
import 'package:pruebatec/pages/menu/pages/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TareasBloc()..add(CargarTareas()),
      child: MaterialApp(
        title: 'PruebaTecnica',
        home: MenuInicial(),
      ),
    );
  }
}
