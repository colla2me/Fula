import 'package:flutter/material.dart';
import '../widgets/extra_actions_button.dart';
import '../widgets/filter_button.dart';
import '../widgets/todo_list.dart';
import '../screens/store_screen.dart';
import '../screens/stats_screen.dart';
import '../screens/add_edit_screen.dart';

enum AppTab {
  todos, store, stats
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  AppTab _activeTab = AppTab.todos;

  Widget _buildBody() {
    switch (_activeTab) {
      case AppTab.todos:
        return TodoList();
      case AppTab.store:
        return StoreScreen(appBarHidden: true);
      case AppTab.stats:
        return StatsScreen();
      default: return null;
    }
  }

  Icon _buildTabIcon(AppTab tab) {
    switch (tab) {
      case AppTab.todos:
        return Icon(Icons.list);
      case AppTab.store:
        return Icon(Icons.store);
      case AppTab.stats:
        return Icon(Icons.star);
      default: return null;
    }
  }

  Text _buildTabName(AppTab tab) {
    switch (tab) {
      case AppTab.todos:
        return Text('Todos');
      case AppTab.store:
        return Text('Store');
      case AppTab.stats:
        return Text('Star');
      default: return null;
    }
  }

  // Widget _buildAppBar() {
  //   final appBar = AppBar(
  //         elevation: 0,
  //         centerTitle: true,
  //         automaticallyImplyLeading: false,
  //         title: Text('Home Page'),
  //         actions: <Widget>[
  //           FilterButton(isActive: _activeTab == AppTab.todos),
  //           ExtraActionsButton()
  //         ],
  //       );

  //   return PreferredSize(
  //     preferredSize: appBar.preferredSize,
  //     child: Offstage(
  //       offstage: _activeTab == AppTab.store ? true : false,
  //       child: appBar,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Home Page'),
        actions: <Widget>[
          FilterButton(isActive: _activeTab == AppTab.todos),
          ExtraActionsButton()
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return AddEditScreen();
              }
            )
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: AppTab.values.indexOf(_activeTab),
        onTap: (index) {
          setState(() {
            _activeTab = AppTab.values[index];
          });
        },
        items: AppTab.values.map((tab) {
          return BottomNavigationBarItem(
            icon: _buildTabIcon(tab),
            title: _buildTabName(tab)
          );
        }).toList(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
