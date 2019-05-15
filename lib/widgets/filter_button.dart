import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/todo_list_model.dart';

class FilterButton extends StatelessWidget {
  final bool isActive;

  FilterButton({Key key, this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AnimatedOpacity(
      opacity: isActive ? 1.0 : 0.0,
      duration: Duration(microseconds: 150),
      child: ScopedModelDescendant<TodoListModel>(
        builder: (context, child, model) {
          return PopupMenuButton<VisibilityFilter>(
            tooltip: 'filter todos',
            onSelected: (filter) {
              model.activeFilter = filter;
            },
            itemBuilder: (context) => _items(context, model),
            icon: Icon(Icons.filter_list),
          );
        },
      ),
    );
  }

  List<PopupMenuItem<VisibilityFilter>> _items(
    BuildContext context, TodoListModel model
  ) {
    final activeStyle = Theme.of(context).textTheme.body1.copyWith(
      color: Theme.of(context).accentColor
    );

    final defaultStyle = Theme.of(context).textTheme.body1;

    return [
      PopupMenuItem<VisibilityFilter>(
        value: VisibilityFilter.active,
        child: Text(
          'show all',
          style: model.activeFilter == VisibilityFilter.all
              ? activeStyle
              : defaultStyle,
        ),
      ),

      PopupMenuItem<VisibilityFilter>(
        value: VisibilityFilter.active,
        child: Text(
          'show active',
          style: model.activeFilter == VisibilityFilter.active
              ? activeStyle
              : defaultStyle,
        ),
      ),

      PopupMenuItem<VisibilityFilter>(
        value: VisibilityFilter.active,
        child: Text(
          'show completed',
          style: model.activeFilter == VisibilityFilter.complete
              ? activeStyle
              : defaultStyle,
        ),
      ),
    ];
  }
}
