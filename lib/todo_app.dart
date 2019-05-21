import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/repository.dart';
import 'core/theme.dart';
import 'scoped_models/todo_list_model.dart';
import 'core/routes.dart';
import 'screens/home_screen.dart';
import 'screens/store_screen.dart';
import 'demo/first_screen.dart';
import 'screens/charts_screen.dart';
import 'screens/expansion_screen.dart';
import 'screens/sliver_list_screen.dart';
import 'tab_bar_navigation.dart';
import 'screens/list_demo_screen.dart';
import 'tubi_tv/tubi_navigation.dart';

class TodoApp extends StatelessWidget {

  final TodosRepository repository;

  TodoApp({
   @required this.repository
  });

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: "Flutter",
      darkTheme: ThemeData.dark(),
      theme: AppSampleTheme.tubiTheme,
      home: ListDemoScreen(),
      routes: {
        AppSampleRoutes.home: (context) => MyHomePage(),
        AppSampleRoutes.store: (context) => StoreScreen(),
        AppSampleRoutes.first: (context) => FirstScreen(),
        AppSampleRoutes.chart: (context) => ChartScreen(),
        AppSampleRoutes.tabbar: (context) => TabBarNavigation(),
        AppSampleRoutes.expansion: (context) => ExpansionListScreen(),
        AppSampleRoutes.sliver: (context) => SliverScreen(),
        AppSampleRoutes.tubi: (context) => TubiNavigation()
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
