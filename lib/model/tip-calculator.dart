import 'package:flutter/material.dart';

final title = 'Tip Calculator';

void main() => runApp(MaterialApp(title: title, home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double billAmount = 0.0;
  double tipPercentage = 0.0;

  @override
  Widget build(BuildContext context) {
    TextField billAmountField = new TextField(
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        try {
          billAmount = double.parse(value);
        } catch (ex) {
          billAmount = 0.0;
        }
      },
      decoration: new InputDecoration(labelText: 'Bill amount(\$)'),
    );

    TextField tipPercentageField = new TextField(
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        try {
          tipPercentage = double.parse(value);
        } catch (ex) {
          tipPercentage = 0.0;
        }
      },
      decoration: new InputDecoration(labelText: 'Tip %', hintText: '15'),
    );

    void calculateTip() {
      double tip = billAmount * tipPercentage / 100;
      double total = billAmount + tip;

      AlertDialog dialog = new AlertDialog(
          title: Text('Summary'),
          content: Text("Tip: \$$tip \nTotal: \$$total"));

      showDialog(context: context, builder: (BuildContext context) => dialog);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10)),
              billAmountField,
              tipPercentageField,
              RaisedButton(
                child: Text('Calculate'),
                onPressed: calculateTip,
              )
            ],
          )),
        ));
  }
}
