import 'dart:developer';

class Pokemon {
  int id;
  String num;
  String name;
  String img;
  String spawnChance;
  List<String> type;
  List<String> weaknesses;
  List<NextEvolution> nextEvolution;

  Pokemon(
      {this.id, this.num, this.name, this.img, this.type, this.spawnChance, this.nextEvolution});

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    name = json['name'];
    img = json['img'];
    type = json['type'].cast<String>();
    weaknesses = json['weaknesses'].cast<String>();
    spawnChance = json['spawn_chance'].toString();

    if (json['next_evolution'] != null) {
      nextEvolution = new List<NextEvolution>();
      json['next_evolution'].forEach((v) {
        nextEvolution.add(new NextEvolution.fromJson(v));
      });
    }
  }
}


class NextEvolution {
  String num;
  String name;

  NextEvolution({this.num, this.name});

  NextEvolution.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
  }

  toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = num;
    data['name'] = name;
    return data;
  }
}