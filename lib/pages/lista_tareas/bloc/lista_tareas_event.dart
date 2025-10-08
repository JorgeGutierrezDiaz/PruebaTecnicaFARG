import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pruebatec/pages/lista_tareas/models/tarea_model.dart';

abstract class TareasEvent extends Equatable {
  const TareasEvent();
  @override
  List<Object?> get props => [];
}

class CargarTareas extends TareasEvent {}

class AgregarTarea extends TareasEvent {
  final Tarea tarea;
  const AgregarTarea(this.tarea);

  @override
  List<Object?> get props => [tarea];
}

class EliminarTarea extends TareasEvent {
  final int index;
  const EliminarTarea(this.index);
  @override
  List<Object?> get props => [index];
}

class EditarTarea extends TareasEvent {
  final int index;
  final String? nuevoTitulo;
  final String? nuevaDescripcion;
  final int? nuevoColor;

  const EditarTarea(
    this.index,
    String text, {
    this.nuevoTitulo,
    this.nuevaDescripcion,
    this.nuevoColor,
  });

  @override
  List<Object?> get props => [index, nuevoTitulo, nuevaDescripcion, nuevoColor];
}

class ToggleCompletado extends TareasEvent {
  final int index;
  final bool completado;
  const ToggleCompletado(this.index, this.completado);
  @override
  List<Object?> get props => [index, completado];
}
