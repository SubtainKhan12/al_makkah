import 'dart:convert';
/// Unassigned : "4"
/// Pending : "20"
/// Done : "11"
/// Cancelled : "6"
/// Closed : "6"

JobStatusModel jobStatusModelFromJson(String str) => JobStatusModel.fromJson(json.decode(str));
String jobStatusModelToJson(JobStatusModel data) => json.encode(data.toJson());
class JobStatusModel {
  JobStatusModel({
      String? unassigned, 
      String? pending, 
      String? done, 
      String? cancelled, 
      String? closed,}){
    _unassigned = unassigned;
    _pending = pending;
    _done = done;
    _cancelled = cancelled;
    _closed = closed;
}

  JobStatusModel.fromJson(dynamic json) {
    _unassigned = json['Unassigned'];
    _pending = json['Pending'];
    _done = json['Done'];
    _cancelled = json['Cancelled'];
    _closed = json['Closed'];
  }
  String? _unassigned;
  String? _pending;
  String? _done;
  String? _cancelled;
  String? _closed;
JobStatusModel copyWith({  String? unassigned,
  String? pending,
  String? done,
  String? cancelled,
  String? closed,
}) => JobStatusModel(  unassigned: unassigned ?? _unassigned,
  pending: pending ?? _pending,
  done: done ?? _done,
  cancelled: cancelled ?? _cancelled,
  closed: closed ?? _closed,
);
  String? get unassigned => _unassigned;
  String? get pending => _pending;
  String? get done => _done;
  String? get cancelled => _cancelled;
  String? get closed => _closed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Unassigned'] = _unassigned;
    map['Pending'] = _pending;
    map['Done'] = _done;
    map['Cancelled'] = _cancelled;
    map['Closed'] = _closed;
    return map;
  }

}