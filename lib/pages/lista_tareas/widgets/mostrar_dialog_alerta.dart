import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_bloc.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_event.dart';
import 'package:pruebatec/pages/lista_tareas/models/tarea_model.dart';
import 'package:pruebatec/pages/lista_tareas/widgets/crear_boton.dart';
import 'package:pruebatec/pages/lista_tareas/widgets/crear_selectorColor.dart';
import 'package:pruebatec/pages/lista_tareas/widgets/crear_textfield.dart';

//USAMOS EL MISMO DIALOG PARA EDITAR QUE PARA AGREGAR
void mostrarDialogoTarea(
  BuildContext context, {
  Tarea? tareaEditar,
  int? index,
}) {
  final esEdicion = tareaEditar != null;

  final tituloController = TextEditingController(
    text: esEdicion ? tareaEditar.titulo : '',
  );
  final descripcionController = TextEditingController(
    text: esEdicion ? tareaEditar.descripcion : '',
  );
  Color colorSeleccionado = esEdicion
      ? Color(tareaEditar.color)
      : const Color.fromARGB(255, 155, 65, 110);

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return StatefulBuilder(
        builder: (context, setState) => ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ),
          child: FadeTransition(
            opacity: animation,
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 20,
              shadowColor: const Color.fromARGB(255, 112, 65, 194),
              contentPadding: EdgeInsets.zero,
              content: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.grey.shade50,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 107, 60, 189),
                            const Color.fromARGB(255, 126, 95, 179),
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(128, 187, 74, 98),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.308),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              esEdicion
                                  ? Icons.edit_rounded
                                  : Icons.add_task_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            esEdicion ? "Editar Tarea" : "Nueva Tarea",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          crearCampoTexto(
                            controller: tituloController,
                            texto: "Título",
                            icono: Icons.title_rounded,
                            textoUsuario: "Ingrese el titulo de la tarea",
                          ),
                          const SizedBox(height: 20),
                          crearCampoTexto(
                            controller: descripcionController,
                            texto: "Descripcion",
                            icono: Icons.description_rounded,
                            textoUsuario: "Agrega detalles...",
                            lineas: 3,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Color de la tarea",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () async {
                              Color? nuevoColor = await showDialog(
                                context: context,
                                builder: (_) => selectorColor(
                                  context,
                                  colorSeleccionado,
                                ),
                              );

                              if (nuevoColor != null) {
                                setState(() {
                                  colorSeleccionado = nuevoColor;
                                });
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color:
                                    colorSeleccionado.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: colorSeleccionado,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorSeleccionado.withValues(
                                        alpha: 0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: colorSeleccionado,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: colorSeleccionado.withValues(
                                              alpha: 0.5),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Text(
                                      "Toca para cambiar el color",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.palette_rounded,
                                    color: colorSeleccionado,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: botonDeAccion(
                              accion: () => Navigator.pop(context),
                              titulo: "Cancelar",
                              esprimario: false,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: botonDeAccion(
                              accion: () {
                                if (tituloController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Por favor ingresa un título"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                if (esEdicion) {
                                  BlocProvider.of<TareasBloc>(context).add(
                                    EditarTarea(
                                      index!,
                                      tituloController.text.trim(),
                                      nuevoTitulo: tituloController.text.trim(),
                                      nuevaDescripcion:
                                          descripcionController.text.trim(),
                                      nuevoColor: colorSeleccionado.value,
                                    ),
                                  );
                                } else {
                                  BlocProvider.of<TareasBloc>(context).add(
                                    AgregarTarea(
                                      Tarea(
                                        titulo: tituloController.text.trim(),
                                        descripcion:
                                            descripcionController.text.trim(),
                                        color: colorSeleccionado.value,
                                      ),
                                    ),
                                  );
                                }
                                Navigator.pop(context);
                              },
                              titulo: "Guardar",
                              esprimario: true,
                              icono: Icons.check_circle_rounded,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
