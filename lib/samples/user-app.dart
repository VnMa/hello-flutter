import 'package:flutter/material.dart';
import 'package:hello_flutter/state/state_container.dart';

final String title = 'Inherited Widget';

main() => runApp(new StateContainer(child: new UserApp()));

class UserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User user;

  Widget get _logInPrompt {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text('Please add user information', style: const TextStyle(fontSize: 18.0),)
        ],
      ),
    );
  }

  Widget get _userInfo {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('${user.firstName} ${user.lastName}', style:  TextStyle(fontSize: 24.0)),
          Text(user.email, style: TextStyle(fontSize: 24.0))

        ],
      )
    );
  }

  void _updateUser(BuildContext context) {
    Navigator.push(context, new MaterialPageRoute(fullscreenDialog: true,
        builder: (context) { return UpdateUserScreen(); }));
  }

  @override
  Widget build(BuildContext context) {
    final container  = StateContainer.of(context);

    user = container.user;

    var body = user != null ? _userInfo : _logInPrompt;

    return Scaffold(
      appBar: new AppBar(title: new Text('Inherited widget test')),
      body: body,
      floatingActionButton: new FloatingActionButton(onPressed: () => _updateUser(context),
      child: new Icon(Icons.edit),),
    );
  }
}


class UpdateUserScreen extends StatelessWidget {
  static final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> firstNameKey = new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> lastNameKey = new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> emailKey= new GlobalKey<FormFieldState<String>>();

  const UpdateUserScreen({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);

    return new Scaffold(
      appBar: new AppBar(title: Text('Edit User Info'),),
      body: new Padding(padding: EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        autovalidate: false,
        child: ListView(
          children: <Widget>[
            TextFormField(
              key: firstNameKey,
              style: Theme.of(context).textTheme.headline,
              decoration: InputDecoration(
                hintText: 'First Name'
              ),
            ),
            TextFormField(
              key: lastNameKey,
              style: Theme.of(context).textTheme.headline,
              decoration: InputDecoration(
                  hintText: 'Last Name'
              ),
            ),
            TextFormField(
              key: emailKey,
              style: Theme.of(context).textTheme.headline,
              decoration: InputDecoration(
                  hintText: 'Email Address'
              ),
            )
          ],
        )
      )
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            final form = formKey.currentState;
            if (form.validate()) {
              var firstName = firstNameKey.currentState.value;
              var lastName = lastNameKey.currentState.value;
              var email = emailKey.currentState.value;

              if (firstName == '') {
                firstName = null;
              }
              if (lastName == '') {
                lastName = null;
              }
              if (email == '') {
                email = null;
              }

              container.updateUserInfo(
                firstName: firstName,
                lastName: lastName,
                email: email
              );

              print('$firstName - $lastName : $email');

              Navigator.pop(context);
            }
          }),
    );
  }
}
