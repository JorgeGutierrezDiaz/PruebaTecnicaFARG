import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_bloc.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_event.dart';
import 'package:pruebatec/pages/lista_tareas/bloc/lista_tareas_state.dart';
import 'package:pruebatec/utils/snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:pruebatec/widgets/menuLateral.dart';

class ListaTareasScreen extends StatelessWidget {
  ListaTareasScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f0),
      drawer: MenuLateral(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Lista de tareas",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: "Nueva tarea",
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) {
                        if (value.trim().isEmpty) return;
                        BlocProvider.of<TareasBloc>(context)
                            .add(AgregarTarea(value));
                        _controller.clear();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final text = _controller.text;
                      if (text.trim().isEmpty) return;
                      BlocProvider.of<TareasBloc>(context)
                          .add(AgregarTarea(text));
                      _controller.clear();
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<TareasBloc, TareasState>(
                builder: (context, state) {
                  if (state.tareas.isEmpty) {
                    return const Center(
                      child: Text(
                        "No hay tareas por mostrar, intenta agregando una",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: state.tareas.length,
                    itemBuilder: (context, index) {
                      final tarea = state.tareas[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: ListTile(
                          onTap: () {
                            final editController =
                                TextEditingController(text: tarea['titulo']);
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Editar tarea"),
                                content: TextField(
                                  controller: editController,
                                  autofocus: true,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Cancelar")),
                                  ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<TareasBloc>(context)
                                            .add(EditarTarea(
                                                index, editController.text));
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Guardar"))
                                ],
                              ),
                            );
                          },
                          leading: Checkbox(
                            value: tarea['completado'],
                            onChanged: (value) {
                              BlocProvider.of<TareasBloc>(context)
                                  .add(ToggleCompletado(index, value ?? false));
                            },
                          ),
                          title: Text(
                            tarea['titulo'],
                            style: TextStyle(
                              decoration: tarea['completado']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: tarea['completado']
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              BlocProvider.of<TareasBloc>(context)
                                  .add(EliminarTarea(index));
                              mostrarSnackBar(
                                context,
                                titulo: "Tarea eliminada",
                                mensaje: tarea['titulo'],
                                tipo: ContentType.failure,
                              );
                            },
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
    );
  }
}
