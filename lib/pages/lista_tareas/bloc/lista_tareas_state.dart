import 'package:equatable/equatable.dart';

class TareasState extends Equatable {
  final List<Map<String, dynamic>> tareas;

  const TareasState({this.tareas = const []});

  TareasState copyWith({List<Map<String, dynamic>>? tareas}) {
    return TareasState(tareas: tareas ?? this.tareas);
  }

  @override
  List<Object?> get props => [tareas];
}
