import 'package:equatable/equatable.dart';
import 'package:pruebatec/pages/lista_tareas/models/tarea_model.dart';

class TareasState extends Equatable {
  final List<Tarea> tareas;

  const TareasState({this.tareas = const []});

  TareasState copyWith({List<Tarea>? tareas}) {
    return TareasState(tareas: tareas ?? this.tareas);
  }

  @override
  List<Object?> get props => [tareas];
}
