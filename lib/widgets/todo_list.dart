import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/todo_list_model.dart';
import 'todo_item.dart';
import '../models/todo.dart';
import '../screens/todo_detail_screen.dart';

class TodoList extends StatelessWidget {

  TodoList({Key key}) : super(key: key);

  Center _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        key: Key('todo loading')
      ),
    );
  }

  ListView _buildList(TodoListModel model) {
    final todos = model.filteredTodos;
    return ListView.builder(
      key:Key('todoList'),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onDismissed: (direction) {
            _removeTodo(context, todo);
          },
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return TodoDetailScreen(
                    todoId: todo.id
                  );
                }
              )
            ).then((todo) {
              if (todo is Todo) {
                _showUndoSnackbar(context, todo);
              }
            });
          },
          onCheckboxChanged: (complete) {
            var toggled = todo.copy(complete: !todo.complete);
            model.updateTodo(toggled);
          },
        );
      },
    );
  }

  void _removeTodo(BuildContext context, Todo todo) {
    TodoListModel.of(context).removeTodo(todo);
    _showUndoSnackbar(context, todo);
  }

  void _showUndoSnackbar(BuildContext context, Todo todo) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        key: Key('snackbar'),
        duration: Duration(seconds: 2),
        backgroundColor: Theme.of(context).backgroundColor,
        content: Text(
          todo.task,
          maxLines: 1,
          overflow:TextOverflow.ellipsis
        ),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            TodoListModel.of(context).addTodo(todo);
          },
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodoListModel>(
      builder: (context, child, model) {
        return Container(
          child: model.isLoading ? _buildLoading() : _buildList(model)
        );
      },
    );
  }
}
