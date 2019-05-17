import 'package:flutter/material.dart';
import 'second_screen.dart';
import 'bus.dart';
import 'count_event.dart';

class FirstScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('FirstScreen'),
      ),
      body: Center(
        child: StreamBuilder<CountEvent>(
          stream: eventBus.on<CountEvent>(),
          builder: (context, snapshot) {
            return snapshot.hasData ? Text('you pushed the button ${snapshot.data.count} times') : Text('waiting for data');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen())),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
