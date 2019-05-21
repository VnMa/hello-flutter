import 'package:flutter/material.dart';
import 'package:hello_flutter/model/pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetail({this.pokemon});

  Widget BodyWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width - 20,
          left: 10.0,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 70.0,
                ),
//            Image.network(pokemon.img),
                Text(pokemon.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
                Text('Height: 0.99 m'),
                Text('Weight: 13.0 kg'),
                Text(
                  'Types',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.type
                      .map((t) => FilterChip(
                      backgroundColor: Colors.amber,
                      label: Text(t),
                      onSelected: (b) {}))
                      .toList(),
                ),
                Text(
                  'Weakness',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.weaknesses == null ? [] : pokemon.weaknesses
                      .map((t) => FilterChip(
                    backgroundColor: Colors.red,
                    label: Text(t, style: TextStyle(color: Colors.white)),
                    onSelected: (b) {},
                  ))
                      .toList(),
                ),
                Text(
                  'Next evolution',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.nextEvolution == null ? [] : pokemon.nextEvolution.map((ne) {
                    return FilterChip(
                        label: Text(
                          ne.name,
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                        onSelected: (b) {});
                  }).toList(),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: pokemon.img,
            child: Container(
              height: 200.0,
                width: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(pokemon.img), fit: BoxFit.cover)
              ),
            )
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
        appBar: AppBar(backgroundColor: Colors.cyan, elevation: 0.0, title: Text(pokemon.name)),
        body: BodyWidget(context));
  }
}
