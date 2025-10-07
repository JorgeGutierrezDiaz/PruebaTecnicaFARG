import 'package:flutter/material.dart';
import 'package:pruebatec/pages/calculadora_propinas/pages/calculadora.dart';
import 'package:pruebatec/pages/consumo_api/pages/consumo_api.dart';
import 'package:pruebatec/pages/lista_tareas/pages/lista_tareas.dart';
import 'package:pruebatec/pages/menu/widgets/opcion.dart';
import 'package:pruebatec/pages/persistencia_datos/pages/persistencia_datos.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 65, 130, 184),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Menú Principal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Selecciona una opción',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Opcion(
            icono: Icons.calculate_outlined,
            titulo: "Calculadora de Propinas",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => CalculadoraPropinas()),
              );
            },
          ),
          Opcion(
            icono: Icons.checklist_outlined,
            titulo: "Lista de Tareas",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => ListaTareasScreen()),
              );
            },
          ),
          Opcion(
            icono: Icons.cloud_download_outlined,
            titulo: "Consumo de API",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => ConsumoApiScreen()),
              );
            },
          ),
          Opcion(
            icono: Icons.save_alt_outlined,
            titulo: "Persistencia de Datos",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => PersistenciaDatosScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
