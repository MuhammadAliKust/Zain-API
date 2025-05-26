import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:zain_api/models/user.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;

  void setUser(UserModel val) {
    _userModel = val;
    notifyListeners();
  }

  UserModel? getUser() => _userModel;
}
