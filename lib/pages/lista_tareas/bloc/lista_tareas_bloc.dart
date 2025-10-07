import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_event.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TareasBloc extends Bloc<TareasEvent, TareasState> {
  TareasBloc() : super(const TareasState()) {
    on<CargarTareas>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final String? data = prefs.getString('tareas');
      if (data != null) {
        emit(state.copyWith(
            tareas: List<Map<String, dynamic>>.from(jsonDecode(data))));
      }
    });

    on<AgregarTarea>((event, emit) async {
      final List<Map<String, dynamic>> nuevaLista = List.from(state.tareas)
        ..add({'titulo': event.titulo, 'completado': false});
      emit(state.copyWith(tareas: nuevaLista));
      /*  mostrarSnackBar(
                        context,
                        titulo: "Tarea agregada",
                        mensaje: text,
                        tipo: ContentType.success,
                      );  */
      await _guardarTareas(nuevaLista);
    });

    on<EliminarTarea>((event, emit) async {
      final List<Map<String, dynamic>> nuevaLista = List.from(state.tareas)
        ..removeAt(event.index);
      emit(state.copyWith(tareas: nuevaLista));
      await _guardarTareas(nuevaLista);
    });

    on<EditarTarea>((event, emit) async {
      final List<Map<String, dynamic>> nuevaLista = List.from(state.tareas);

      final tareaModificada = {
        'titulo': event.titulo,
        'completado': nuevaLista[event.index]['completado'],
      };
      nuevaLista[event.index] = tareaModificada;

      emit(state.copyWith(tareas: nuevaLista));
      await _guardarTareas(nuevaLista);
    });

    on<ToggleCompletado>((event, emit) async {
      final List<Map<String, dynamic>> nuevaLista = List.from(state.tareas);

      // tenemos que hacer un nuevo mapa para que detecte el cambio
      final tareaModificada = {
        'titulo': nuevaLista[event.index]['titulo'],
        'completado': event.completado,
      };
      nuevaLista[event.index] = tareaModificada;

      emit(state.copyWith(tareas: nuevaLista));
      await _guardarTareas(nuevaLista);
    });
  }

  Future<void> _guardarTareas(List<Map<String, dynamic>> tareas) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tareas', jsonEncode(tareas));
  }
}
