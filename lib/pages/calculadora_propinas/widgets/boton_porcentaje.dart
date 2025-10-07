import 'package:flutter/material.dart';

class BotonPorcentaje extends StatelessWidget {
  final String texto;
  final double valor;
  final VoidCallback onPressed;

  const BotonPorcentaje({
    super.key,
    required this.texto,
    required this.valor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: const Color.fromARGB(255, 65, 130, 184),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
