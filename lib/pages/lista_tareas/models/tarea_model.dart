class Tarea {
  final int? id;
  final String titulo;
  final String descripcion;
  final int color;
  final bool completado;

  Tarea({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.color,
    this.completado = false,
  });

  Tarea copyWith({
    int? id,
    String? titulo,
    String? descripcion,
    int? color,
    bool? completado,
  }) {
    return Tarea(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      color: color ?? this.color,
      completado: completado ?? this.completado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'color': color,
      'completado': completado ? 1 : 0,
    };
  }

  factory Tarea.fromMap(Map<String, dynamic> map) {
    return Tarea(
      id: map['id'] as int?,
      titulo: map['titulo'] as String,
      descripcion: map['descripcion'] as String,
      color: map['color'] as int,
      completado: (map['completado'] as int) == 1,
    );
  }
}
