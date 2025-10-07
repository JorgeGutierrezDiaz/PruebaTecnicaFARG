import 'package:equatable/equatable.dart';

abstract class TareasEvent extends Equatable {
  const TareasEvent();
  @override
  List<Object?> get props => [];
}

class CargarTareas extends TareasEvent {}

class AgregarTarea extends TareasEvent {
  final String titulo;
  const AgregarTarea(this.titulo);
  @override
  List<Object?> get props => [titulo];
}

class EliminarTarea extends TareasEvent {
  final int index;
  const EliminarTarea(this.index);
  @override
  List<Object?> get props => [index];
}

class EditarTarea extends TareasEvent {
  final int index;
  final String titulo;
  const EditarTarea(this.index, this.titulo);
  @override
  List<Object?> get props => [index, titulo];
}

class ToggleCompletado extends TareasEvent {
  final int index;
  final bool completado;
  const ToggleCompletado(this.index, this.completado);
  @override
  List<Object?> get props => [index, completado];
}
