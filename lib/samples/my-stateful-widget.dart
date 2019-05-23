import 'package:flutter/material.dart';

final title = 'Stateful widget';

void main() => runApp(MaterialApp(title: title, home: MyApp()));

class Contact {
  String fullname;
  String email;

  Contact(this.fullname, this.email);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;

  final List<String> titles = ['Hello', 'Flutter', 'is', 'so', 'awesome', "is\'nt", 'it'];

  void handlePress() {
    print("handle press:   $_index / ${titles.length}");

    setState(() {
      if (_index >= titles.length - 1) {
        _index = 0;
      } else {
        _index += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: Text(titles[_index], style: TextStyle(fontSize: 50),)),
              Padding(padding: EdgeInsets.all(10)),
              RaisedButton(
                  child: Center(child: Text('Press me!', style: TextStyle(color: Colors.white),)),
                  color: Colors.red,
                  onPressed: handlePress)
            ],
          )),
        ));
  }
}
