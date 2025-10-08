import 'package:pruebatec/pages/lista_tareas/models/tarea_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class tareasDatabase {
  static final tareasDatabase _instance = tareasDatabase._internal();
  factory tareasDatabase() => _instance;
  tareasDatabase._internal();

  static Database? bd;

  Future<Database> get baseDeDatos async {
    //si la base de datos ya fue abierta, regresamos la misma
    if (bd != null) return bd!;

    //si no estaba abierta, la iniciamos
    bd = await iniciarDB();
    return bd!;
  }

  Future<Database> iniciarDB() async {
    final dbruta = await getDatabasesPath();
    final ruta = join(dbruta, 'tareas.db');

    return await openDatabase(
      ruta,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tareas(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT,
            descripcion TEXT,
            color INTEGER,
            completado INTEGER
          )
        ''');
      },
    );
  }

  Future<List<Tarea>> getTareas() async {
    final db = await baseDeDatos;
    final result = await db.query('tareas');
    return result.map((e) => Tarea.fromMap(e)).toList();
  }

  Future<int> insertarTarea(Tarea tarea) async {
    final db = await baseDeDatos;
    return await db.insert('tareas', tarea.toMap());
  }

  Future<int> actualizarTarea(Tarea tarea) async {
    final db = await baseDeDatos;
    return await db.update(
      'tareas',
      tarea.toMap(),
      where: 'id = ?',
      whereArgs: [tarea.id],
    );
  }

  Future<int> eliminarTarea(int id) async {
    final db = await baseDeDatos;
    return await db.delete(
      'tareas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
