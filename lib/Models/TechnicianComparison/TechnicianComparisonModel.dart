import 'dart:convert';
/// ttchcod : "001"
/// Name : "IRFAN"
/// Mobile : "03053421934"
/// Assigned : "3"
/// Pending : "0"
/// Installed : "0"

TechnicianComparisonModel technicianComparisonModelFromJson(String str) => TechnicianComparisonModel.fromJson(json.decode(str));
String technicianComparisonModelToJson(TechnicianComparisonModel data) => json.encode(data.toJson());
class TechnicianComparisonModel {
  TechnicianComparisonModel({
      String? ttchcod, 
      String? name, 
      String? mobile, 
      String? assigned, 
      String? pending, 
      String? installed,}){
    _ttchcod = ttchcod;
    _name = name;
    _mobile = mobile;
    _assigned = assigned;
    _pending = pending;
    _installed = installed;
}

  TechnicianComparisonModel.fromJson(dynamic json) {
    _ttchcod = json['ttchcod'];
    _name = json['Name'];
    _mobile = json['Mobile'];
    _assigned = json['Assigned'];
    _pending = json['Pending'];
    _installed = json['Installed'];
  }
  String? _ttchcod;
  String? _name;
  String? _mobile;
  String? _assigned;
  String? _pending;
  String? _installed;
TechnicianComparisonModel copyWith({  String? ttchcod,
  String? name,
  String? mobile,
  String? assigned,
  String? pending,
  String? installed,
}) => TechnicianComparisonModel(  ttchcod: ttchcod ?? _ttchcod,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  assigned: assigned ?? _assigned,
  pending: pending ?? _pending,
  installed: installed ?? _installed,
);
  String? get ttchcod => _ttchcod;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get assigned => _assigned;
  String? get pending => _pending;
  String? get installed => _installed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ttchcod'] = _ttchcod;
    map['Name'] = _name;
    map['Mobile'] = _mobile;
    map['Assigned'] = _assigned;
    map['Pending'] = _pending;
    map['Installed'] = _installed;
    return map;
  }

}