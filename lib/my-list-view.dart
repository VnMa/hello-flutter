import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final title = 'My List View';

class Contact {
  String fullname;
  String email;

  Contact(this.fullname, this.email);
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<Contact> contacts = new List<Contact>();
    contacts.add(new Contact("An Vo", "anvo@mail.com"));
    contacts.add(Contact('David', 'david@mail.com'));
    contacts.add(Contact('John', 'john@mail.com'));
    contacts.add(new Contact("An Vo", "anvo@mail.com"));
    contacts.add(Contact('David', 'david@mail.com'));
    contacts.add(Contact('John', 'john@mail.com'));
    contacts.add(new Contact("An Vo", "anvo@mail.com"));
    contacts.add(Contact('David', 'david@mail.com'));
    contacts.add(Contact('John', 'john@mail.com'));
    contacts.add(new Contact("An Vo", "anvo@mail.com"));
    contacts.add(Contact('David', 'david@mail.com'));
    contacts.add(Contact('John', 'john@mail.com'));
    contacts.add(new Contact("An Vo", "anvo@mail.com"));
    contacts.add(Contact('David', 'david@mail.com'));
    contacts.add(Contact('John', 'john@mail.com'));
    contacts.add(new Contact("An Vo", "anvo@mail.com"));
    contacts.add(Contact('David', 'david@mail.com'));
    contacts.add(Contact('John', 'john@mail.com'));

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
//            itemExtent: 20.0,
            itemCount: contacts.length,
            itemBuilder: (BuildContext context, int index) {
              Contact contact = contacts[index];
              return ListTile(
                leading: CircleAvatar(child: Text(contact.fullname[0])),
                title: Text(contact.fullname),
                subtitle: Text(contact.email),
              );
            },
          )
        ),
      ),
    );
  }
}