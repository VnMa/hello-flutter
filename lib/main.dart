import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:collection';

const MockItems = [
  {'id': 1, 'name': 'For'},
  {'id': 2, 'name': 'Each'},
  {'id': 3, 'name': 'Let'},
  {'id': 4, 'name': 'Const'},
  {'id': 5, 'name': 'Final'},
  {'id': 6, 'name': 'Recursion'},
  {'id': 7, 'name': 'Stack'},
  {'id': 8, 'name': 'Heap'},
  {'id': 9, 'name': 'If condition'},
  {'id': 10, 'name': 'Where'},
  {'id': 11, 'name': 'For'},
  {'id': 12, 'name': 'Each'},
  {'id': 13, 'name': 'Let'},
  {'id': 14, 'name': 'Const'},
  {'id': 15, 'name': 'Final'},
  {'id': 16, 'name': 'Recursion'},
  {'id': 17, 'name': 'Stack'},
  {'id': 18, 'name': 'Heap'},
  {'id': 19, 'name': 'If condition'},
  {'id': 20, 'name': 'Where'},
];

class Item {
  int id;
  String name;

  Item({this.id, this.name});

  Item.fromJson(Map<String, dynamic> json) {
    this.id = json['id'] as int;
    this.name = json['name'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'item: ${name}';
  }
}

class CartModel extends Model {
  final List<Item> _items = new List();

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  int get totalPrice => _items.length * 40;

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
  }
}

void main() {
  final cart = CartModel();
  runApp(ScopedModel<CartModel>(model: cart, child: MyApp()));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.yellow),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/catalog': (context) => MyCatalog(),
        '/cart': (context) => MyCart()
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(icon: Icon(Icons.person),
                        hintText: 'What do people call you?',
                        labelText: 'Name *'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your name';
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                        child: Text('Submit'),
                        onPressed: () {
                          print(_formKey.currentState);

                          Navigator.pushNamed(context, '/catalog');
                        }),
                  )
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}


class MyCatalog extends StatefulWidget {
  @override
  _MyCatalogState createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  List<Item> items = new List();

  _loadItems() {
    MockItems.forEach((item) => items.add(Item.fromJson(item)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Catalog',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            )
          ],

        ),
        body: items.length <= 0 ? CircularProgressIndicator()
            : ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return buildItem(index);
          },
        )
    );
  }

  Widget buildItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: LimitedBox(
        maxHeight: 48.0,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.primaries[index % Colors.primaries.length],

              ),
            ),
            SizedBox(
              width: 24.0,
            ),
            Expanded(
                child: Text(items[index].name)
            ),
            SizedBox(
              width: 24.0,
            ),
            _AddButton(item: items[index])
//           RaisedButton(
//             child: Text('ADD'),
//             onPressed: () {
//               print(items[index]);
//             },
//           )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItems();
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
      builder: (context, child, cart) {
        return FlatButton(
            onPressed: () =>
            cart.items.contains(item) ? null : cart.add(item),
            splashColor: Colors.yellow,
            child: cart.items.contains(item) ? Icon(Icons.check) : Text('ADD')
        );
      },
    );
  }
}


class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.display2),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList()
              )
            ),
            Container(height: 4, color: Colors.black),
            _CartTotal()
          ],
        )
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
      builder: (context, _, cart) {
        return ListView(
          children: cart.items.map((item) => Text('. ${item.name}', style: Theme.of(context).textTheme.title,)).toList(),
        );
      },
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScopedModelDescendant<CartModel>(
              builder: (context, _, cart) => Text('Total \$${cart.totalPrice}', style: Theme.of(context).textTheme.display4.copyWith(fontSize: 48),),
            ),
            SizedBox(width: 24),
            FlatButton(
              child: Text('BUY'),
              color: Colors.white,
              onPressed: () =>
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Buying is currently not supported')))
              ,
            )
          ],
        ),
      ),
    );
  }
}
