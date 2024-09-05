import 'dart:convert';
/// Unassigned : "29"
/// Pending : "0"
/// Installed : "0"
/// Cancelled : "0"
/// Closed : "0"

JobStatusModel jobStatusModelFromJson(String str) => JobStatusModel.fromJson(json.decode(str));
String jobStatusModelToJson(JobStatusModel data) => json.encode(data.toJson());
class JobStatusModel {
  JobStatusModel({
      String? unassigned, 
      String? pending, 
      String? installed, 
      String? cancelled, 
      String? closed,}){
    _unassigned = unassigned;
    _pending = pending;
    _installed = installed;
    _cancelled = cancelled;
    _closed = closed;
}

  JobStatusModel.fromJson(dynamic json) {
    _unassigned = json['Unassigned'];
    _pending = json['Pending'];
    _installed = json['Installed'];
    _cancelled = json['Cancelled'];
    _closed = json['Closed'];
  }
  String? _unassigned;
  String? _pending;
  String? _installed;
  String? _cancelled;
  String? _closed;
JobStatusModel copyWith({  String? unassigned,
  String? pending,
  String? installed,
  String? cancelled,
  String? closed,
}) => JobStatusModel(  unassigned: unassigned ?? _unassigned,
  pending: pending ?? _pending,
  installed: installed ?? _installed,
  cancelled: cancelled ?? _cancelled,
  closed: closed ?? _closed,
);
  String? get unassigned => _unassigned;
  String? get pending => _pending;
  String? get installed => _installed;
  String? get cancelled => _cancelled;
  String? get closed => _closed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Unassigned'] = _unassigned;
    map['Pending'] = _pending;
    map['Installed'] = _installed;
    map['Cancelled'] = _cancelled;
    map['Closed'] = _closed;
    return map;
  }

}