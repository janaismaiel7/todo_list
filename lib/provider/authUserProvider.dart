import 'package:flutter/material.dart';
import 'package:todo_list/model/myUser.dart';

class Authuserprovider extends ChangeNotifier {
  Myuser? currentUser;

  void updateUser(Myuser newUser) {
    currentUser = newUser;
 notifyListeners();
  }
}
