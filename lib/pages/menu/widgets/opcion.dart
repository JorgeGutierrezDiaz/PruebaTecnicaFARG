import 'package:flutter/material.dart';

class Opcion extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final VoidCallback onTap;

  const Opcion({
    super.key,
    required this.icono,
    required this.titulo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: Color.fromRGBO(7, 2, 2, 1),
      child: ListTile(
        leading: Icon(icono, size: 30),
        title: Text(titulo,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
