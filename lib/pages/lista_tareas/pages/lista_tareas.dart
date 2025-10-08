import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_bloc.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_event.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_state.dart';
import 'package:pruebatec/pages/lista_tareas/models/tarea_model.dart';
import 'package:pruebatec/pages/lista_tareas/widgets/crear_boton.dart';
import 'package:pruebatec/pages/lista_tareas/widgets/crear_selectorColor.dart';
import 'package:pruebatec/pages/lista_tareas/widgets/crear_textfield.dart';
import 'package:pruebatec/pages/lista_tareas/widgets/mostrar_dialog_alerta.dart';
import 'package:pruebatec/utils/snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:pruebatec/widgets/menuLateral.dart';

class ListaTareasScreen extends StatelessWidget {
  const ListaTareasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TareasBloc>().add(CargarTareas());

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      drawer: MenuLateral(),
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple,
                            Colors.deepPurple.shade300
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.task_alt_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      "Lista de tareas",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => mostrarDialogoTarea(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple,
                            Colors.deepPurple.shade400
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_rounded,
                                color: Colors.white, size: 22),
                            SizedBox(width: 8),
                            Text(
                              "Nueva tarea",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<TareasBloc, TareasState>(
                  builder: (context, state) {
                    if (state.tareas.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox_rounded,
                                size: 80, color: Colors.grey.shade300),
                            const SizedBox(height: 16),
                            Text(
                              "No hay tareas",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Intenta agregando una nueva",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade400),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: state.tareas.length,
                      itemBuilder: (context, index) {
                        final tarea = state.tareas[index];
                        final tareaColor = Color(tarea.color);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Container(width: 4, color: tareaColor),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.read<TareasBloc>().add(
                                                    ToggleCompletado(
                                                      index,
                                                      !tarea.completado,
                                                    ),
                                                  );
                                            },
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                color: tarea.completado
                                                    ? tareaColor
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: tareaColor,
                                                    width: 2),
                                              ),
                                              child: tarea.completado
                                                  ? const Icon(Icons.check,
                                                      size: 16,
                                                      color: Colors.white)
                                                  : null,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  tarea.titulo,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: tarea.completado
                                                        ? Colors.grey
                                                        : Colors.black87,
                                                    decoration: tarea.completado
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : TextDecoration.none,
                                                  ),
                                                ),
                                                if (tarea.descripcion
                                                    .isNotEmpty) ...[
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    tarea.descripcion,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: tarea.completado
                                                          ? Colors.grey.shade400
                                                          : Colors
                                                              .grey.shade600,
                                                      decoration: tarea
                                                              .completado
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration.none,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.edit_outlined,
                                                color: Colors.grey.shade600,
                                                size: 20),
                                            onPressed: () {
                                              mostrarDialogoTarea(context,
                                                  tareaEditar: tarea,
                                                  index: index);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete_outline,
                                                color: Colors.red.shade400,
                                                size: 20),
                                            onPressed: () {
                                              context
                                                  .read<TareasBloc>()
                                                  .add(EliminarTarea(index));
                                              mostrarSnackBar(
                                                context,
                                                titulo: "Tarea eliminada",
                                                mensaje: tarea.titulo,
                                                tipo: ContentType.failure,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
