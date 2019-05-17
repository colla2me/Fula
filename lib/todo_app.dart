import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/repository.dart';
import 'core/theme.dart';
import 'core/routes.dart';
import 'scoped_models/todo_list_model.dart';
import 'screens/home_screen.dart';
import 'screens/store_screen.dart';
import 'screens/add_edit_screen.dart';
import 'demo/first_screen.dart';
import 'screens/charts_screen.dart';
// import 'tab_bar_navigation.dart';

class TodoApp extends StatelessWidget {

  final TodosRepository repository;

  TodoApp({
   @required this.repository
  });

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: "TodoApp",
      theme: AppSampleTheme.theme,
      routes: {
        AppSampleRoutes.home: (context) => MyHomePage(),
        AppSampleRoutes.store: (context) => StoreScreen(),
        AppSampleRoutes.addTodo: (context) => AddEditScreen(),
        AppSampleRoutes.first: (context) => FirstScreen(),
        AppSampleRoutes.chart: (context) => ChartScreen()
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
