import 'package:flutter/material.dart';
import 'package:lista_tarefas/screens/tarefa/lista.dart';
import 'package:lista_tarefas/theme/custom_theme.dart';
import 'package:lista_tarefas/theme/my_themes.dart';
import 'package:lista_tarefas/models/tarefa.dart';
import 'package:lista_tarefas/database/app.database.dart';

void main() {
  runApp(
    CustomTheme(
      initialThemeKey: MyThemeKeys.LIGHT,
      child: TarefaApp(),
    ),
  );
}

class TarefaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.of(context),
      home: ListaTarefa(),
    );
  }
}
