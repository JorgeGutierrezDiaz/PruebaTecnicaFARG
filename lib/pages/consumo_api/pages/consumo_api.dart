import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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

    //con esto detectamos cuando llega al final y hacemos otra carga de imagenes
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
      return null;
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
        SnackBar(content: Text('Error: ${e}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      //use el stack para que pudiera poner la barra de busqueda flotando
      body: PopScope(
        canPop: false,
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 16,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(90, 0, 0, 0),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: buscadorController,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: 'Buscar imagenes...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: const Icon(Icons.search,
                        color: Color.fromARGB(255, 139, 100, 207)),
                    suffixIcon: buscadorController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              buscadorController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                  ),
                  onChanged: (_) => setState(() {}),
                  onSubmitted: (_) => buscarImagenes(),
                ),
              ),
            ),
            Positioned.fill(
              child: imagenes.isEmpty && !cargando
                  ? const Center(
                      child: Text(
                        'Busca un termino para ver imagenes',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : MasonryGridView.count(
                      controller: _scrollController,
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 80),
                      itemCount: imagenes.length + (cargando ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= imagenes.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(50),
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          );
                        }

                        final urlDeImagen = imagenes[index];

                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          columnCount: 2,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: () async {
                                  //esto sirve para poner la imagen en tamaño completo
                                  await showDialog(
                                    context: context,
                                    builder: (context) => Center(
                                      child: AnimatedScale(
                                        scale: 1.1,
                                        duration:
                                            const Duration(milliseconds: 100),
                                        child: Hero(
                                          tag: urlDeImagen,
                                          child: Image.network(urlDeImagen),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: urlDeImagen,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 8,
                                    shadowColor:
                                        const Color.fromARGB(255, 0, 0, 0),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.network(
                                      urlDeImagen,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Container(
                                          height: 150,
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
