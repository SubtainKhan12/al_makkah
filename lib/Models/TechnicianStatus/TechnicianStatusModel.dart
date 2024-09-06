import 'dart:convert';
/// Pending : "1"
/// Installed : "1"
/// Closed : "1"

TechnicianStatusModel technicianStatusModelFromJson(String str) => TechnicianStatusModel.fromJson(json.decode(str));
String technicianStatusModelToJson(TechnicianStatusModel data) => json.encode(data.toJson());
class TechnicianStatusModel {
  TechnicianStatusModel({
      String? pending, 
      String? installed, 
      String? closed,}){
    _pending = pending;
    _installed = installed;
    _closed = closed;
}

  TechnicianStatusModel.fromJson(dynamic json) {
    _pending = json['Pending'];
    _installed = json['Installed'];
    _closed = json['Closed'];
  }
  String? _pending;
  String? _installed;
  String? _closed;
TechnicianStatusModel copyWith({  String? pending,
  String? installed,
  String? closed,
}) => TechnicianStatusModel(  pending: pending ?? _pending,
  installed: installed ?? _installed,
  closed: closed ?? _closed,
);
  String? get pending => _pending;
  String? get installed => _installed;
  String? get closed => _closed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Pending'] = _pending;
    map['Installed'] = _installed;
    map['Closed'] = _closed;
    return map;
  }

}