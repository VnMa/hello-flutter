import 'package:flutter/material.dart';
import 'package:hello_flutter/model/pokemon.dart';
import 'package:hello_flutter/pages/pokemon-detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

final title = 'Poke App';

void main() => runApp(MaterialApp(title: title, home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
  List<Pokemon> pokemonList = new List<Pokemon>();


  Future<String> fetchData() async {
    print('begin fetch data');
    var res = await http.get(
        Uri.encodeFull(url), headers: {"Accept": 'application/json'});

    setState(() {
      var dataConvertedToJson = jsonDecode(res.body);
      if (dataConvertedToJson['pokemon'] != null) {
        dataConvertedToJson['pokemon'].forEach((d) {
          pokemonList.add(new Pokemon.fromJson(d));
        });
      }
    });

    return 'Successful';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
        title: Center(child: Text(title)),
        backgroundColor: Colors.cyan,
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.refresh), backgroundColor: Colors.cyan, onPressed: null),
      body:
      pokemonList == null ? Center(
          child: CircularProgressIndicator()
      ) :
      Container(
        child: GridView.count(
          padding: EdgeInsets.all(10.0),
          crossAxisCount: 2,
          children: pokemonList.map((poke) =>
              Padding(
                padding: EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => PokemonDetail(pokemon: poke)));
                  },
                  child: Hero(
                    tag: poke.img,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(poke.img))
                            ),
                          ),
                          Text(poke.name, style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                ),
              )).toList(),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }
}

