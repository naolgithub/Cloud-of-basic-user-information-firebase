import 'package:flutter/material.dart';
import 'package:profile_flutter/models/client_user.dart';

class UserProvider extends ChangeNotifier {
  //we are storing user model here
  //(since as we know provider is for the purpose of storing)
  ClientUser _user = ClientUser(
    uid: '',
    username: '',
    email: '',
  );
  ClientUser get user => _user;
  setUser(ClientUser user) {
    _user = user;
    notifyListeners();
  }
}
