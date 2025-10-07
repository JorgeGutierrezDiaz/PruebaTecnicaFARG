import 'package:flutter/material.dart';

class ResultadoItem extends StatelessWidget {
  final String label;
  final double valor;
  final IconData icono;
  final bool isTotal;

  const ResultadoItem({
    super.key,
    required this.label,
    required this.valor,
    required this.icono,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icono,
              color: const Color.fromARGB(255, 86, 160, 221),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 20 : 18,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          '\$${valor.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 24 : 20,
            fontWeight: FontWeight.bold,
            color: isTotal
                ? const Color.fromARGB(255, 65, 130, 184)
                : Colors.black87,
          ),
        ),
      ],
    );
  }
}
