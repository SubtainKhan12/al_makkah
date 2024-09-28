import 'dart:convert';
/// ttchcod : "001"
/// Name : "IRFAN"
/// Mobile : "03053421934"
/// Pending : "10"
/// Done : "6"

TechnicianComparisonModel technicianComparisonModelFromJson(String str) => TechnicianComparisonModel.fromJson(json.decode(str));
String technicianComparisonModelToJson(TechnicianComparisonModel data) => json.encode(data.toJson());
class TechnicianComparisonModel {
  TechnicianComparisonModel({
      String? ttchcod, 
      String? name, 
      String? mobile, 
      String? pending, 
      String? done,}){
    _ttchcod = ttchcod;
    _name = name;
    _mobile = mobile;
    _pending = pending;
    _done = done;
}

  TechnicianComparisonModel.fromJson(dynamic json) {
    _ttchcod = json['ttchcod'];
    _name = json['Name'];
    _mobile = json['Mobile'];
    _pending = json['Pending'];
    _done = json['Done'];
  }
  String? _ttchcod;
  String? _name;
  String? _mobile;
  String? _pending;
  String? _done;
TechnicianComparisonModel copyWith({  String? ttchcod,
  String? name,
  String? mobile,
  String? pending,
  String? done,
}) => TechnicianComparisonModel(  ttchcod: ttchcod ?? _ttchcod,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  pending: pending ?? _pending,
  done: done ?? _done,
);
  String? get ttchcod => _ttchcod;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get pending => _pending;
  String? get done => _done;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ttchcod'] = _ttchcod;
    map['Name'] = _name;
    map['Mobile'] = _mobile;
    map['Pending'] = _pending;
    map['Done'] = _done;
    return map;
  }

}