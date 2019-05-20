import 'package:flutter/material.dart';

class ExpansionScreen extends StatelessWidget {
  static final route = "/expansion";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expansion"),
      ),
      body: Center(
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text("Expansion title"),
          leading: Icon(Icons.ac_unit),
          backgroundColor: Colors.white12,
          children: <Widget>[
            ListTile(
              title: Text("List title"),
              subtitle: Text("Subtitle"),
            )
          ],
        ),
      ),
    );
  }
}

class ExpandState {
  bool isOpen;
  int index;
  ExpandState(this.index, this.isOpen);
}

class ExpansionListScreen extends StatefulWidget {
  @override
  _ExpansionListScreenState createState() => _ExpansionListScreenState();
}

class _ExpansionListScreenState extends State<ExpansionListScreen> {

  List<ExpandState> _stateList;

  _ExpansionListScreenState() {
    _stateList = [];
    for (int i = 0; i < 10; i++) {
      _stateList.add(ExpandState(i, false));
    }
  }

  _expandAtIndex(int index, bool isExpanded) {
    setState(() {
      _stateList.forEach((item) {
        if (item.index == index) {
          item.isOpen = !isExpanded;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expansion List"),
      ),

      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (index, bol) {
            _expandAtIndex(index, bol);
          },
          children: _stateList.map((item) {
            return ExpansionPanel(
              isExpanded: item.isOpen,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text('header title no.${item.index}'),
                );
              },
              body: ListTile(
                title: Text("expansion no.${item.index}"),
              )
            );
          }).toList()
        ),
      ),
    );
  }
}
