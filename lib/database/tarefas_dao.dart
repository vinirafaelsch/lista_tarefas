import 'package:lista_tarefas/models/tarefa.dart';
import 'package:sqflite/sqflite.dart';

import 'app.database.dart';

class TarefasDao {

  static const String tableSQL = 'CREATE TABLE tarefas('
      'id INTEGER PRIMARY KEY, '
      'tarefa TEXT, '
      'descricao TEXT)';

  Future<int> save(Tarefa tarefa) async{
    final Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    return db.insert('tarefas', tarefaMap);
  }

  Future<int> update(Tarefa tarefa) async{
    final Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    return db.update('tarefas', tarefaMap, where: 'id = ?', whereArgs: [tarefa.id]);
  }

  Future<int> delete(int id) async{
    final Database db = await getDatabase();
    return db.delete('tarefas', where: 'id = ?', whereArgs: [id]);
  }

  Map<String, dynamic> toMap(Tarefa tarefa) {
    final Map<String, dynamic> tarefaMap = Map();
    tarefaMap['tarefa'] = tarefa.tarefa;
    tarefaMap['descricao'] = tarefa.descricao;
    return tarefaMap;
  }

  Future<List<Tarefa>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('tarefas');
    List<Tarefa> tarefas = toList(result);
    return tarefas;
  }

  List<Tarefa> toList(List<Map<String, dynamic>> result) {
    final List<Tarefa> tarefas = List();
    for (Map<String, dynamic> row in result) {
      final Tarefa tarefa = Tarefa(
        row['id'],
        row['tarefa'],
        row['descricao'],
      );
      tarefas.add(tarefa);
    }
    return tarefas;
  }

}