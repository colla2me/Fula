import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoItem extends StatelessWidget {

  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Todo todo;

  TodoItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.todo
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          value: todo.complete,
          onChanged: onCheckboxChanged,
        ),
        title:Text(
          todo.task,
          style: Theme.of(context).textTheme.title
        ),
        subtitle: Text(
          todo.note,
          maxLines: 1,
          overflow:TextOverflow.ellipsis,
          style:Theme.of(context).textTheme.subhead
        ),
      ),
    );
  }
}
