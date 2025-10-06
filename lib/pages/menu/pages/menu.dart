import 'package:flutter/material.dart';
import 'package:pruebatec/pages/calculadora_propinas/pages/calculadora.dart';
import 'package:pruebatec/pages/consumo_api/pages/consumo_api.dart';
import 'package:pruebatec/pages/lista_tareas/pages/lista_tareas.dart';
import 'package:pruebatec/pages/menu/widgets/opcion.dart';
import 'package:pruebatec/pages/persistencia_datos/pages/persistencia_datos.dart';
import 'package:pruebatec/widgets/app_bar.dart';

class MenuInicial extends StatelessWidget {
  const MenuInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(
        titulo: "Menu inicial",
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Opcion(
            icono: Icons.calculate_outlined,
            titulo: "Calculadora de Propinas",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CalculadoraPropinas()),
              );
            },
          ),
          Opcion(
            icono: Icons.checklist_outlined,
            titulo: "Lista de Tareas",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ListaTareasScreen()),
              );
            },
          ),
          Opcion(
            icono: Icons.cloud_download_outlined,
            titulo: "Consumo de API",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ConsumoApiScreen()),
              );
            },
          ),
          Opcion(
            icono: Icons.save_alt_outlined,
            titulo: "Persistencia de Datos",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const PersistenciaDatosScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
