import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

final title = 'Bloc Demo';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        theme: ThemeData(
            primarySwatch: Colors.green
        ),
        home: ProviderDemo()
    );
  }
}


class ProviderDemo extends StatefulWidget {
  @override
  _ProviderDemoState createState() => _ProviderDemoState();
}

class _ProviderDemoState extends State<ProviderDemo> {
  CounterBloc _counterBloc = new CounterBloc(initialCount: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title)),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.add),
            tooltip: 'Increment',
            onPressed: () => _counterBloc.increment(),
          ),
          SizedBox(height: 10,),
          FloatingActionButton(
            child: Icon(Icons.remove),
            tooltip: 'Decrement',
            onPressed: () => _counterBloc.decrement(),
          )
        ],
      ),
      body: StreamBuilder(stream: _counterBloc.counterObservable,
          initialData: 0,
          builder: (context, snapshot) {
        return Center( child: Text( snapshot.data.toString()));
          })
    );
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }
}

class CounterBloc {
  int initialCount = 0;
  BehaviorSubject<int> _subjectCounter;

  CounterBloc({this.initialCount}) {
    _subjectCounter = new BehaviorSubject<int>.seeded(this.initialCount);
  }

  Observable<int> get counterObservable => _subjectCounter.stream;

  void increment() {
    initialCount++;
    _subjectCounter.sink.add(initialCount);
  }

  void decrement() {
    initialCount--;
    _subjectCounter.sink.add(initialCount);
  }

  void dispose() {
    _subjectCounter.close();
  }
}