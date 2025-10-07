class CalculadoraPropinaService {
  static double calcularPropina(double monto, double porcentaje) {
    if (monto <= 0 || porcentaje < 0) {
      return 0.0;
    }
    return monto * (porcentaje / 100);
  }

  static double calcularTotal(double monto, double porcentaje) {
    if (monto <= 0) {
      return 0.0;
    }

    return monto + calcularPropina(monto, porcentaje);
  }

  static String formatearMoneda(double valor) {
    return '\${valor.toStringAsFixed(2)}';
  }
}
