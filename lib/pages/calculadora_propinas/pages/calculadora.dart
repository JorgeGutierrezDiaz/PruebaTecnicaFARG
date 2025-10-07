import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pruebatec/pages/calculadora_propinas/services/calculadoraPropinaService.dart';
import 'package:pruebatec/pages/calculadora_propinas/widgets/boton_porcentaje.dart';
import 'package:pruebatec/pages/calculadora_propinas/widgets/itemResultado.dart';
import 'package:pruebatec/widgets/menuLateral.dart';

class CalculadoraPropinas extends StatefulWidget {
  const CalculadoraPropinas({super.key});

  @override
  State<CalculadoraPropinas> createState() => _CalculadoraPropinasState();
}

class _CalculadoraPropinasState extends State<CalculadoraPropinas> {
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _porcentajeController = TextEditingController();

  double _montoPropina = 0.0;
  double _montoTotal = 0.0;

  void _calcularPropina() {
    final monto = double.tryParse(_montoController.text) ?? 0.0;
    final porcentaje = double.tryParse(_porcentajeController.text) ?? 0.0;

    setState(() {
      _montoPropina =
          CalculadoraPropinaService.calcularPropina(monto, porcentaje);
      _montoTotal = CalculadoraPropinaService.calcularTotal(monto, porcentaje);
    });
  }

  void _limpiar() {
    setState(() {
      _montoController.clear();
      _porcentajeController.clear();
      _montoPropina = 0.0;
      _montoTotal = 0.0;
    });
  }

  @override
  void dispose() {
    _montoController.dispose();
    _porcentajeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      body: PopScope(
        canPop: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            //esto del strech, es para que ocupe todo el ancho de la oantalla
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Calculadora de propinas",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _montoController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Monto de la cuenta',
                  prefixIcon: const Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (_) => _calcularPropina(),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _porcentajeController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Porcentaje de propina',
                  prefixIcon: const Icon(Icons.percent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (_) => _calcularPropina(),
              ),
              const SizedBox(height: 32),
              const Text(
                'Porcentajes comunes:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BotonPorcentaje(
                    texto: '10%',
                    valor: 10,
                    onPressed: () {
                      _porcentajeController.text = '10';
                      _calcularPropina();
                    },
                  ),
                  BotonPorcentaje(
                    texto: '15%',
                    valor: 15,
                    onPressed: () {
                      _porcentajeController.text = '15';
                      _calcularPropina();
                    },
                  ),
                  BotonPorcentaje(
                    texto: '20%',
                    valor: 20,
                    onPressed: () {
                      _porcentajeController.text = '20';
                      _calcularPropina();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color.fromARGB(255, 83, 151, 207),
                    width: 3,
                  ),
                ),
                child: Column(
                  children: [
                    ResultadoItem(
                      label: 'Propina:',
                      valor: _montoPropina,
                      icono: Icons.card_giftcard,
                    ),
                    const Divider(height: 30),
                    ResultadoItem(
                      label: 'Total a pagar:',
                      valor: _montoTotal,
                      icono: Icons.receipt_long,
                      isTotal: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _limpiar,
                label: const Text('Limpiar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  backgroundColor: const Color.fromARGB(255, 51, 104, 44),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
