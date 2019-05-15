
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/todo_list_model.dart';

enum ExtraAction { toggleAllComplete, clearCompleted }

class ExtraActionsButton extends StatelessWidget {

  ExtraActionsButton({
    Key key
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodoListModel>(
      builder: (BuildContext context, Widget child, TodoListModel model) {
        return PopupMenuButton<ExtraAction>(
          key: Key('ExtraActionsButton'),
          onSelected: (action) {
            if (action ==ExtraAction.toggleAllComplete) {
              model.toggleAll();
            } else if (action ==ExtraAction.clearCompleted) {
              model.clearCompleted();
            }
          },
          itemBuilder: (context) => <PopupMenuItem<ExtraAction>>[
            PopupMenuItem<ExtraAction>(
              value: ExtraAction.toggleAllComplete,
              child: Text(
                model.todos.any((it) => !it.complete) ? 'mark all incomplete' : 'mark all complete'
              ),
            ),
            PopupMenuItem<ExtraAction>(
              value: ExtraAction.clearCompleted,
              child: Text('clear completed'),
            )
          ],
        );
      },
    );
  }
}
