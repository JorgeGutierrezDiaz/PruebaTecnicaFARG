import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pruebatec/pages/consumo_api/widgets/cardAnimada.dart';
import 'package:pruebatec/providers/consumo_apiService.dart';
import 'package:pruebatec/widgets/menuLateral.dart';

class ConsumoApiScreen extends StatefulWidget {
  const ConsumoApiScreen({super.key});

  @override
  State<ConsumoApiScreen> createState() => _ConsumoApiScreenState();
}

class _ConsumoApiScreenState extends State<ConsumoApiScreen> {
  final TextEditingController buscadorController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<String> imagenes = [];
  bool cargando = false;
  int numeroPagina = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !cargando) {
        cargasMasImagenes();
      }
    });
  }

  void buscarImagenes() {
    setState(() {
      imagenes.clear();
      numeroPagina = 0;
    });
    cargasMasImagenes();
  }

  final ConsumoApiService apiService = ConsumoApiService();

  void cargasMasImagenes() async {
    if (buscadorController.text.isEmpty) {
      return;
    }

    setState(() => cargando = true);

    try {
      final nuevasImagenes = await apiService.obtenerImagenes(
        buscadorController.text,
        numeroPagina + 1,
      );

      setState(() {
        imagenes.addAll(nuevasImagenes);
        numeroPagina++;
        cargando = false;
      });
    } catch (e) {
      setState(() => cargando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      drawer: MenuLateral(),
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: buscadorController,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: 'Buscar imágenes...',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: Colors.deepPurple,
                          ),
                          suffixIcon: buscadorController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.close_rounded,
                                    color: Colors.grey.shade600,
                                  ),
                                  onPressed: () {
                                    buscadorController.clear();
                                    setState(() {
                                      imagenes.clear();
                                      numeroPagina = 0;
                                    });
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                        ),
                        onChanged: (_) => setState(() {}),
                        onSubmitted: (_) => buscarImagenes(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: imagenes.isEmpty && !cargando
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.image_search_rounded,
                                size: 80,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Busca imágenes',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Ingresa un término para comenzar',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      )
                    //Este plugin es estilo para pinterest, nos hace imagenes de diferentes tamaños y cuadriculas
                    : MasonryGridView.count(
                        controller: _scrollController,
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        padding: const EdgeInsets.all(16),
                        itemCount: imagenes.length + (cargando ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= imagenes.length) {
                            //circulo de progreso para carga infinita
                            return Container(
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Cargando...',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          final urlDeImagen = imagenes[index];

                          return cardAnimada(
                            key: ValueKey(urlDeImagen),
                            urlImagen: urlDeImagen,
                            index: index,
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
