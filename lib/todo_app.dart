import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/repository.dart';
import 'core/theme.dart';
import 'core/routes.dart';
import 'scoped_models/todo_list_model.dart';
import 'screens/home_screen.dart';
import 'screens/store_screen.dart';

class TodoApp extends StatelessWidget {

  final TodosRepository repository;

  TodoApp({
   @required this.repository
  });

  @override
  Widget build(BuildContext context) {
    var app = MaterialApp(
      title: "TodoApp",
      theme: AppSampleTheme.theme,
      routes: {
        AppSampleRoutes.home: (context) => MyHomePage(title: 'Home Page'),
        AppSampleRoutes.store: (context) => StorePage(),
      },
    );

    return ScopedModel<TodoListModel>(
      model:TodoListModel(
        repository: repository
      ),
      child: app,
    );
  }
}
