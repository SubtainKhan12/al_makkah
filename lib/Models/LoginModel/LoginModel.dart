import 'dart:convert';
/// user : {"id":76,"tusrid":"irfan","tusrnam":"IRFAN","tusrpwd":"7549","tusrsts":"Yes","tusrtyp":"Technician","tmobnum":"03047738612","temladd":"sohaibsaleem89@gmail.com","techcod":"001","token":null}
/// error : 200
/// message : "Login success"

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());
class LoginModel {
  LoginModel({
      User? user, 
      num? error, 
      String? message,}){
    _user = user;
    _error = error;
    _message = message;
}

  LoginModel.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _error = json['error'];
    _message = json['message'];
  }
  User? _user;
  num? _error;
  String? _message;
LoginModel copyWith({  User? user,
  num? error,
  String? message,
}) => LoginModel(  user: user ?? _user,
  error: error ?? _error,
  message: message ?? _message,
);
  User? get user => _user;
  num? get error => _error;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['error'] = _error;
    map['message'] = _message;
    return map;
  }

}

/// id : 76
/// tusrid : "irfan"
/// tusrnam : "IRFAN"
/// tusrpwd : "7549"
/// tusrsts : "Yes"
/// tusrtyp : "Technician"
/// tmobnum : "03047738612"
/// temladd : "sohaibsaleem89@gmail.com"
/// techcod : "001"
/// token : null

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      num? id, 
      String? tusrid, 
      String? tusrnam, 
      String? tusrpwd, 
      String? tusrsts, 
      String? tusrtyp, 
      String? tmobnum, 
      String? temladd, 
      String? techcod, 
      dynamic token,}){
    _id = id;
    _tusrid = tusrid;
    _tusrnam = tusrnam;
    _tusrpwd = tusrpwd;
    _tusrsts = tusrsts;
    _tusrtyp = tusrtyp;
    _tmobnum = tmobnum;
    _temladd = temladd;
    _techcod = techcod;
    _token = token;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _tusrid = json['tusrid'];
    _tusrnam = json['tusrnam'];
    _tusrpwd = json['tusrpwd'];
    _tusrsts = json['tusrsts'];
    _tusrtyp = json['tusrtyp'];
    _tmobnum = json['tmobnum'];
    _temladd = json['temladd'];
    _techcod = json['techcod'];
    _token = json['token'];
  }
  num? _id;
  String? _tusrid;
  String? _tusrnam;
  String? _tusrpwd;
  String? _tusrsts;
  String? _tusrtyp;
  String? _tmobnum;
  String? _temladd;
  String? _techcod;
  dynamic _token;
User copyWith({  num? id,
  String? tusrid,
  String? tusrnam,
  String? tusrpwd,
  String? tusrsts,
  String? tusrtyp,
  String? tmobnum,
  String? temladd,
  String? techcod,
  dynamic token,
}) => User(  id: id ?? _id,
  tusrid: tusrid ?? _tusrid,
  tusrnam: tusrnam ?? _tusrnam,
  tusrpwd: tusrpwd ?? _tusrpwd,
  tusrsts: tusrsts ?? _tusrsts,
  tusrtyp: tusrtyp ?? _tusrtyp,
  tmobnum: tmobnum ?? _tmobnum,
  temladd: temladd ?? _temladd,
  techcod: techcod ?? _techcod,
  token: token ?? _token,
);
  num? get id => _id;
  String? get tusrid => _tusrid;
  String? get tusrnam => _tusrnam;
  String? get tusrpwd => _tusrpwd;
  String? get tusrsts => _tusrsts;
  String? get tusrtyp => _tusrtyp;
  String? get tmobnum => _tmobnum;
  String? get temladd => _temladd;
  String? get techcod => _techcod;
  dynamic get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['tusrid'] = _tusrid;
    map['tusrnam'] = _tusrnam;
    map['tusrpwd'] = _tusrpwd;
    map['tusrsts'] = _tusrsts;
    map['tusrtyp'] = _tusrtyp;
    map['tmobnum'] = _tmobnum;
    map['temladd'] = _temladd;
    map['techcod'] = _techcod;
    map['token'] = _token;
    return map;
  }

}