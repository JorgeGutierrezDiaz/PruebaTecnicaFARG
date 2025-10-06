import 'package:flutter/material.dart';
import 'package:pruebatec/pages/menu/pages/menu.dart';

class appBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final bool mostrarHome;
  const appBarCustom({
    super.key,
    required this.titulo,
    this.mostrarHome = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 29, 56, 6),
      centerTitle: true,
      title: Text(
        titulo,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: mostrarHome
          ? IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MenuInicial()),
                );
              },
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
