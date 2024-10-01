import 'dart:convert';
/// texpid : "1"
/// texpdsc : "Salary"
/// texpsts : "A"
/// tinsusr : ""
/// tinsdat : "2024-10-01"
/// tupdusr : "74"
/// tupddat : "2024-10-01"

GetExpenseModel getExpenseModelFromJson(String str) => GetExpenseModel.fromJson(json.decode(str));
String getExpenseModelToJson(GetExpenseModel data) => json.encode(data.toJson());
class GetExpenseModel {
  GetExpenseModel({
      String? texpid, 
      String? texpdsc, 
      String? texpsts, 
      String? tinsusr, 
      String? tinsdat, 
      String? tupdusr, 
      String? tupddat,}){
    _texpid = texpid;
    _texpdsc = texpdsc;
    _texpsts = texpsts;
    _tinsusr = tinsusr;
    _tinsdat = tinsdat;
    _tupdusr = tupdusr;
    _tupddat = tupddat;
}

  GetExpenseModel.fromJson(dynamic json) {
    _texpid = json['texpid'];
    _texpdsc = json['texpdsc'];
    _texpsts = json['texpsts'];
    _tinsusr = json['tinsusr'];
    _tinsdat = json['tinsdat'];
    _tupdusr = json['tupdusr'];
    _tupddat = json['tupddat'];
  }
  String? _texpid;
  String? _texpdsc;
  String? _texpsts;
  String? _tinsusr;
  String? _tinsdat;
  String? _tupdusr;
  String? _tupddat;
GetExpenseModel copyWith({  String? texpid,
  String? texpdsc,
  String? texpsts,
  String? tinsusr,
  String? tinsdat,
  String? tupdusr,
  String? tupddat,
}) => GetExpenseModel(  texpid: texpid ?? _texpid,
  texpdsc: texpdsc ?? _texpdsc,
  texpsts: texpsts ?? _texpsts,
  tinsusr: tinsusr ?? _tinsusr,
  tinsdat: tinsdat ?? _tinsdat,
  tupdusr: tupdusr ?? _tupdusr,
  tupddat: tupddat ?? _tupddat,
);
  String? get texpid => _texpid;
  String? get texpdsc => _texpdsc;
  String? get texpsts => _texpsts;
  String? get tinsusr => _tinsusr;
  String? get tinsdat => _tinsdat;
  String? get tupdusr => _tupdusr;
  String? get tupddat => _tupddat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['texpid'] = _texpid;
    map['texpdsc'] = _texpdsc;
    map['texpsts'] = _texpsts;
    map['tinsusr'] = _tinsusr;
    map['tinsdat'] = _tinsdat;
    map['tupdusr'] = _tupdusr;
    map['tupddat'] = _tupddat;
    return map;
  }

}