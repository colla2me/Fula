import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/todo_list_model.dart';
import '../models/todo.dart';

class AddEditScreen extends StatefulWidget {

  final String todoId;

  AddEditScreen({
    Key key,
    this.todoId
  }) : super(key:key ?? Key('AddEditScreen'));

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static GlobalKey<FormState> _formKey =GlobalKey<FormState>();

  String _task;
  String _note;

  bool get isEditing => widget.todoId !=null;

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'edit todo' : 'add todo'
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key:_formKey,
          autovalidate: false,
          onWillPop: () {
            return Future(() => true);
          },
          child: ScopedModelDescendant<TodoListModel>(
            builder: (context, child, model) {
              final task = model.todoById(widget.todoId);
              return ListView(
                children: <Widget>[
                  TextFormField(
                    initialValue: task?.task ?? '',
                    autofocus: !isEditing,
                    style: textTheme.headline,
                    decoration: InputDecoration(
                      hintText: 'What needs to be done'
                    ),
                    validator: (val) {
                      return val.trim().isEmpty ? 'Please enter some text' : null;
                    },
                    onSaved: (val) => _task = val,
                  ),

                  TextFormField(
                    initialValue: task?.note ?? '',
                    maxLines: 8,
                    style: textTheme.subhead,
                    decoration: InputDecoration(
                      hintText: 'Additional Notes...',
                    ),
                    onSaved: (val) => _note = val,
                  )
                ],
              );
            },
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: isEditing ? 'save todo' : 'save new todo',
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          final form =_formKey.currentState;
          if (form.validate()) {
            form.save();

            var model =TodoListModel.of(context);
            if (isEditing) {
              var todo = model.todoById(widget.todoId);
              model.updateTodo(todo.copy(task: _task, note:_note));
            } else {
              model.addTodo(Todo(_task, note:_note));
            }

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
