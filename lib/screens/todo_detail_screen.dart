import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/todo_list_model.dart';
import '../models/todo.dart';
import '../screens/add_edit_screen.dart';

class TodoDetailScreen extends StatelessWidget {

  final String todoId;

  TodoDetailScreen({
    @required this.todoId
  }) : super(key: Key('TodoDetailScreen'));

  Row _buildListRow(BuildContext context, TodoListModel model) {
    final todo = model.todoById(todoId) ?? Todo('');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Checkbox(
            value: todo.complete,
            onChanged: (complete) {
              model.updateTodo(todo.copy(complete: !todo.complete));
            },
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 16),
                child: Text(todo.task),
              ),
              Text(
                todo.note,
                style: Theme.of(context).textTheme.subhead,
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<TodoListModel>(
      builder: (context, child, model) {

        var todo = model.todoById(todoId) ?? Todo('');

        return Scaffold(
          appBar: AppBar(
            title: Text('Todo Detail'),
            actions: <Widget>[
              IconButton(
                tooltip: 'delete todo',
                icon: Icon(Icons.delete),
                onPressed: () {
                  model.removeTodo(todo);
                  Navigator.pop(context, todo);
                },
              )
            ],
          ),

          body: Padding(
            padding: EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return _buildListRow(context, model);
              },
            )
          ),

          floatingActionButton: FloatingActionButton(
            tooltip: 'edit todo',
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AddEditScreen(todoId: todoId);
                  }
                )
              );
            },
          ),
        );
      },
    );
  }
}
