class Tarefa {
  final int id;
  final String tarefa;
  final String descricao;

  Tarefa(this.id, this.tarefa, this.descricao);

  @override
  String toString() {
    return 'Tarefa{tarefa: $tarefa, obs: $descricao}';
  }

  @override
  bool operator ==(Object other) =>
      other is Tarefa &&
      tarefa.runtimeType == other.runtimeType &&
      tarefa == other.tarefa &&
          descricao == other.descricao;

  @override
  int get hashCode => tarefa.hashCode ^ descricao.hashCode;
}
