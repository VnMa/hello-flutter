import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

final title = 'My Http Get data';

void main() => runApp(MaterialApp(title: title, home: MyHttpGet()));

class MyHttpGet extends StatefulWidget {
  @override
  _MyHttpGetState createState() => _MyHttpGetState();
}

class _MyHttpGetState extends State<MyHttpGet> {
  final String url = 'https://swapi.co/api/people';
  List data;

  Future<String> getHttpData() async {
    print('get Http data? ');
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    print(res.body);

    setState(() {
      var dataConvertedToJson = json.decode(res.body);
      data = dataConvertedToJson['results'];
    });

    return 'Successful';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: data == null ? 0 : data.length,
//        itemExtent: 20.0,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              child: new Center(
                  child: new Column(
                    // Stretch the cards in horizontal axis
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Card(
                        child: new Container(
                          child: new Text(
                            // Read the name field value and set it in the Text widget
                            data[index]['name'],
                            // set some style to text
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.lightBlueAccent),
                          ),
                          // added padding
                          padding: const EdgeInsets.all(15.0),
                        ),
                      )
                    ],
                  )),
            );
          },
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.getHttpData();
  }
}
