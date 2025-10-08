import 'package:flutter/material.dart';

Widget botonDeAccion({
  required VoidCallback accion,
  required String titulo,
  required bool esprimario,
  IconData? icono,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: accion,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: esprimario
              ? LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                )
              : null,
          color: esprimario ? null : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
          boxShadow: esprimario
              ? [
                  BoxShadow(
                    color: Colors.deepPurple.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icono != null) ...[
              Icon(
                icono,
                color: esprimario ? Colors.white : Colors.grey.shade700,
                size: 20,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              titulo,
              style: TextStyle(
                color: esprimario ? Colors.white : Colors.grey.shade700,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
