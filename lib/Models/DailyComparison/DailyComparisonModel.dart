import 'dart:convert';
/// Date : "05-09-2024"
/// Day : "Thursday"
/// Jobs : "5"
/// Pending : "2"
/// Installed : "3"

DailyComparisonModel dailyComparisonModelFromJson(String str) => DailyComparisonModel.fromJson(json.decode(str));
String dailyComparisonModelToJson(DailyComparisonModel data) => json.encode(data.toJson());
class DailyComparisonModel {
  DailyComparisonModel({
      String? date, 
      String? day, 
      String? jobs, 
      String? pending, 
      String? installed,}){
    _date = date;
    _day = day;
    _jobs = jobs;
    _pending = pending;
    _installed = installed;
}

  DailyComparisonModel.fromJson(dynamic json) {
    _date = json['Date'];
    _day = json['Day'];
    _jobs = json['Jobs'];
    _pending = json['Pending'];
    _installed = json['Installed'];
  }
  String? _date;
  String? _day;
  String? _jobs;
  String? _pending;
  String? _installed;
DailyComparisonModel copyWith({  String? date,
  String? day,
  String? jobs,
  String? pending,
  String? installed,
}) => DailyComparisonModel(  date: date ?? _date,
  day: day ?? _day,
  jobs: jobs ?? _jobs,
  pending: pending ?? _pending,
  installed: installed ?? _installed,
);
  String? get date => _date;
  String? get day => _day;
  String? get jobs => _jobs;
  String? get pending => _pending;
  String? get installed => _installed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Date'] = _date;
    map['Day'] = _day;
    map['Jobs'] = _jobs;
    map['Pending'] = _pending;
    map['Installed'] = _installed;
    return map;
  }

}