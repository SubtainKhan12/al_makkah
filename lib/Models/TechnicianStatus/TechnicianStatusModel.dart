import 'dart:convert';
/// Pending : "10"
/// DONE : "6"
/// Closed : "0"

TechnicianStatusModel technicianStatusModelFromJson(String str) => TechnicianStatusModel.fromJson(json.decode(str));
String technicianStatusModelToJson(TechnicianStatusModel data) => json.encode(data.toJson());
class TechnicianStatusModel {
  TechnicianStatusModel({
      String? pending, 
      String? done, 
      String? closed,}){
    _pending = pending;
    _done = done;
    _closed = closed;
}

  TechnicianStatusModel.fromJson(dynamic json) {
    _pending = json['Pending'];
    _done = json['DONE'];
    _closed = json['Closed'];
  }
  String? _pending;
  String? _done;
  String? _closed;
TechnicianStatusModel copyWith({  String? pending,
  String? done,
  String? closed,
}) => TechnicianStatusModel(  pending: pending ?? _pending,
  done: done ?? _done,
  closed: closed ?? _closed,
);
  String? get pending => _pending;
  String? get done => _done;
  String? get closed => _closed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Pending'] = _pending;
    map['DONE'] = _done;
    map['Closed'] = _closed;
    return map;
  }

}