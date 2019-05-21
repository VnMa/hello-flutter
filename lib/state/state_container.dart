import 'package:flutter/material.dart';

class User {
  String firstName;
  String lastName;
  String email;

  User(this.firstName, this.lastName, this.email);
}

class StateContainer extends StatefulWidget {
  final Widget child;
  final User user;

  StateContainer({@required this.child, this.user});

  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer) as _InheritedStateContainer).data;
  }

  @override
  StateContainerState createState() => StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  User user;

  void updateUserInfo({firstName, lastName, email}) {
    if (user == null) {
      user = new User(firstName, lastName, email);
      setState(() {
        user = user;
      });
    } else {
      setState(() {
        user.firstName = firstName ?? user.firstName;
        user.lastName = lastName ?? user.lastName;
        user.email = email ?? user.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(data: this, child: widget.child);
  }
}


class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;

  const _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  })
      : super(key: key, child: child);

//  static _InheritedStateContainer of(BuildContext context) {
//    return context.inheritFromWidgetOfExactType(_InheritedStateContainer) as _InheritedStateContainer;
//  }

  @override
  bool updateShouldNotify(_InheritedStateContainer old) {
    return false;
  }
}