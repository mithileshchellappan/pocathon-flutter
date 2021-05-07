import "package:flutter/cupertino.dart";
import 'package:votefromhome/models/user.dart';


class UserProvider with ChangeNotifier {
  User _currentUser;

  User get currentUser => _currentUser;


  set currentUser(User currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }

 
}
