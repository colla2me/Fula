import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/repository.dart';
import 'core/theme.dart';
import 'scoped_models/todo_list_model.dart';
import 'core/router.dart';

class TodoApp extends StatelessWidget {

  final TodosRepository repository;

  TodoApp({
   @required this.repository
  });

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: "Flutter",
      // darkTheme: ThemeData.dark(),
      theme: AppSampleTheme.tubiTheme,
      onGenerateRoute: Router.generateRoute,
    );
    return ScopedModel<TodoListModel>(
      model:TodoListModel(
        repository: repository
      ),
      child: app,
    );
  }
}
