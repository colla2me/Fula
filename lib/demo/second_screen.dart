import 'package:flutter/material.dart';
import 'bus.dart';
import 'count_event.dart';

class SecondScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CountEvent>(
      stream: eventBus.on<CountEvent>(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Second Screen'),
          ),
          body: Center(
            child: snapshot.hasData ? Text('you pushed the button ${snapshot.data.count} times') : Text('waiting for data'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (snapshot.hasData) {
                eventBus.fire(CountEvent(snapshot.data.count + 1));
              } else {
                eventBus.fire(CountEvent(1));
              }
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
