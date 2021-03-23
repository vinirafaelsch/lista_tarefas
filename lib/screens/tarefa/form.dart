import 'package:flutter/material.dart';
import 'package:lista_tarefas/components/editor.dart';
import 'package:lista_tarefas/database/tarefas_dao.dart';
import 'package:lista_tarefas/models/tarefa.dart';

class FormTarefa extends StatefulWidget {
  final Tarefa tarefa;

  FormTarefa({this.tarefa});

  @override
  State<StatefulWidget> createState() {
    return FormTarefaState();
  }
}

class FormTarefaState extends State<FormTarefa> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controladorCampoTarefa =
  TextEditingController();
  final TextEditingController _controladorCampoDescricao =
  TextEditingController();
  int _id = null;
  double _value = 60;
  String dropdownValue = 'One';

  @override
  void initState() {
    super.initState();
    if (widget.tarefa != null) {
      _id = widget.tarefa.id;
      _controladorCampoTarefa.text = widget.tarefa.tarefa;
      _controladorCampoDescricao.text = widget.tarefa.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Formulário de Tarefas'),
        ),
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Editor(
                      controlador: _controladorCampoTarefa,
                      rotulo: 'Tarefa',
                      dica: 'Informe a tarefa',
                      icone: Icons.assignment),
                  Editor(
                      controlador: _controladorCampoDescricao,
                      rotulo: 'Descricao',
                      dica: 'Informe a descricao',
                      icone: Icons.assignment),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        elevation: 24,
                        onChanged: (String newValue) {
                          setState(() => dropdownValue = newValue);
                        },
                        items: <String>['One', 'Two', 'Three', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Slider(
                        value: _value,
                        min: 0,
                        max: 100,
                        divisions: 5,
                        label: _value.round().toString(),
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (double value) {
                          setState(() => _value = value);
                        },
                      )),
                  RaisedButton(
                      padding: const EdgeInsets.all(16),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Confirmar',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() => _saveTarefa(context));
                        }
                      }),
                  SizedBox(height: 16),
                  RaisedButton(
                      padding: const EdgeInsets.all(16),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Excluir',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        showAlertDialog(context);
                      }),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.network(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg')),
                ],
              ),
            )));
  }

  void _saveTarefa(context) {
    TarefasDao _dao = new TarefasDao();
    if (_id != null) {
      if(_controladorCampoDescricao.text != "" || _controladorCampoTarefa.text != "") {
        final tarefaAlterada = Tarefa(_id, _controladorCampoTarefa.text,
            _controladorCampoDescricao.text);
        _dao.update(tarefaAlterada).then((id) => Navigator.pop(context));
      } else {
        return;
      }
    } else {
     if(_controladorCampoDescricao.text != "" && _controladorCampoTarefa.text != ""){
        final tarefaCriada = Tarefa(
            0, _controladorCampoTarefa.text, _controladorCampoDescricao.text);
        _dao.save(tarefaCriada).then((id) => Navigator.pop(context));
      } else {
        return;
      }
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continuar"),
      onPressed: () {
        Navigator.pop(context);
        setState(() => _excluir(context));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Exclusão de Tarefas"),
      content: Text("Você deseja excluir esta tarefa?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _excluir(BuildContext context) {
    TarefasDao _dao = new TarefasDao();
    _dao.delete(_id).then((id) => Navigator.pop(context));
  }
}