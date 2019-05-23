import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
final title = 'Provider Demo';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: ChangeNotifierProvider<Counter>(
          builder: (_) => Counter(1),
          child: ProviderDemo())
    );
  }
}


class ProviderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
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
            onPressed: counter.increment,
          ),
          SizedBox(height: 10,),
          FloatingActionButton(
            child: Icon(Icons.remove),
            tooltip: 'Decrement',
            onPressed: counter.decrement,
          )
        ],
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the button this many times'),
              Text('${counter.getCounter()}', style: Theme.of(context).textTheme.display2)
            ],
          ),
        ),
    );
  }
}


class Counter with ChangeNotifier {
  int _counter;

  Counter(this._counter);

  getCounter() => _counter;
  setCounter(int c) => _counter = c;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }


}