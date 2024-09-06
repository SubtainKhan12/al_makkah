import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/LoginModel/LoginModel.dart';

class Shared_pref with ChangeNotifier{

  static Future saveuser(User user)async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("id", user.id??"");
    sp.setString("userId", user.tusrid??"");
    sp.setString("userName", user.tusrnam??"");
    sp.setString("userEmail", user.temladd??"");
    sp.setString("userStatus", user.tusrsts??"");
    sp.setString("userType", user.tusrtyp??"");
    sp.setString("userMobile", user.tmobnum??"");
    sp.setString("technicianCode", user.techcod??"");
  }

}