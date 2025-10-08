import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_event.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_state.dart';
import 'package:pruebatec/pages/lista_tareas/models/tarea_model.dart';
import 'package:pruebatec/providers/sqlite_service.dart';

class TareasBloc extends Bloc<TareasEvent, TareasState> {
  final tareasDatabase _db = tareasDatabase();

  TareasBloc() : super(const TareasState()) {
    on<CargarTareas>((event, emit) async {
      final tareas = await _db.getTareas();
      emit(state.copyWith(tareas: tareas));
    });

    on<AgregarTarea>((event, emit) async {
      final id = await _db.insertarTarea(event.tarea);
      final nuevaTarea = event.tarea.copyWith(id: id);
      final List<Tarea> nuevaLista = List.from(state.tareas)..add(nuevaTarea);
      emit(state.copyWith(tareas: nuevaLista));
    });

    on<EliminarTarea>((event, emit) async {
      final tarea = state.tareas[event.index];
      if (tarea.id != null) await _db.eliminarTarea(tarea.id!);
      final List<Tarea> nuevaLista = List.from(state.tareas)
        ..removeAt(event.index);
      emit(state.copyWith(tareas: nuevaLista));
    });

    on<EditarTarea>((event, emit) async {
      final tarea = state.tareas[event.index].copyWith(
        titulo: event.nuevoTitulo,
        descripcion: event.nuevaDescripcion,
        color: event.nuevoColor,
      );
      if (tarea.id != null) await _db.actualizarTarea(tarea);
      final List<Tarea> nuevaLista = List.from(state.tareas);
      nuevaLista[event.index] = tarea;
      emit(state.copyWith(tareas: nuevaLista));
    });

    on<ToggleCompletado>((event, emit) async {
      final tarea =
          state.tareas[event.index].copyWith(completado: event.completado);
      if (tarea.id != null) await _db.actualizarTarea(tarea);
      final List<Tarea> nuevaLista = List.from(state.tareas);
      nuevaLista[event.index] = tarea;
      emit(state.copyWith(tareas: nuevaLista));
    });
  }
}
