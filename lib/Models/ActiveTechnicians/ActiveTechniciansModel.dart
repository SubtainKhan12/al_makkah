import 'dart:convert';
/// techid : "1"
/// ttchcod : "001"
/// ttchdsc : "IRFAN"
/// tadd001 : "42 GD"
/// tadd002 : ".."
/// tphnnum : "03053421934"
/// tmobnum : "03053421934"
/// temladd : "IRFAN@GMAIL.COM"
/// tnicnum : null
/// ttchint : null
/// tlatval : null
/// tlngval : null
/// ttchsts : "A"
/// tinsdat : "2024-09-02"
/// tinsusr : "74"
/// tupdusr : null
/// tupddat : null
/// tctycod : null
/// tctgcod : null
/// ttchsms : null

ActiveTechniciansModel activeTechniciansModelFromJson(String str) => ActiveTechniciansModel.fromJson(json.decode(str));
String activeTechniciansModelToJson(ActiveTechniciansModel data) => json.encode(data.toJson());
class ActiveTechniciansModel {
  ActiveTechniciansModel({
      String? techid, 
      String? ttchcod, 
      String? ttchdsc, 
      String? tadd001, 
      String? tadd002, 
      String? tphnnum, 
      String? tmobnum, 
      String? temladd, 
      dynamic tnicnum, 
      dynamic ttchint, 
      dynamic tlatval, 
      dynamic tlngval, 
      String? ttchsts, 
      String? tinsdat, 
      String? tinsusr, 
      dynamic tupdusr, 
      dynamic tupddat, 
      dynamic tctycod, 
      dynamic tctgcod, 
      dynamic ttchsms,}){
    _techid = techid;
    _ttchcod = ttchcod;
    _ttchdsc = ttchdsc;
    _tadd001 = tadd001;
    _tadd002 = tadd002;
    _tphnnum = tphnnum;
    _tmobnum = tmobnum;
    _temladd = temladd;
    _tnicnum = tnicnum;
    _ttchint = ttchint;
    _tlatval = tlatval;
    _tlngval = tlngval;
    _ttchsts = ttchsts;
    _tinsdat = tinsdat;
    _tinsusr = tinsusr;
    _tupdusr = tupdusr;
    _tupddat = tupddat;
    _tctycod = tctycod;
    _tctgcod = tctgcod;
    _ttchsms = ttchsms;
}

  ActiveTechniciansModel.fromJson(dynamic json) {
    _techid = json['techid'];
    _ttchcod = json['ttchcod'];
    _ttchdsc = json['ttchdsc'];
    _tadd001 = json['tadd001'];
    _tadd002 = json['tadd002'];
    _tphnnum = json['tphnnum'];
    _tmobnum = json['tmobnum'];
    _temladd = json['temladd'];
    _tnicnum = json['tnicnum'];
    _ttchint = json['ttchint'];
    _tlatval = json['tlatval'];
    _tlngval = json['tlngval'];
    _ttchsts = json['ttchsts'];
    _tinsdat = json['tinsdat'];
    _tinsusr = json['tinsusr'];
    _tupdusr = json['tupdusr'];
    _tupddat = json['tupddat'];
    _tctycod = json['tctycod'];
    _tctgcod = json['tctgcod'];
    _ttchsms = json['ttchsms'];
  }
  String? _techid;
  String? _ttchcod;
  String? _ttchdsc;
  String? _tadd001;
  String? _tadd002;
  String? _tphnnum;
  String? _tmobnum;
  String? _temladd;
  dynamic _tnicnum;
  dynamic _ttchint;
  dynamic _tlatval;
  dynamic _tlngval;
  String? _ttchsts;
  String? _tinsdat;
  String? _tinsusr;
  dynamic _tupdusr;
  dynamic _tupddat;
  dynamic _tctycod;
  dynamic _tctgcod;
  dynamic _ttchsms;
ActiveTechniciansModel copyWith({  String? techid,
  String? ttchcod,
  String? ttchdsc,
  String? tadd001,
  String? tadd002,
  String? tphnnum,
  String? tmobnum,
  String? temladd,
  dynamic tnicnum,
  dynamic ttchint,
  dynamic tlatval,
  dynamic tlngval,
  String? ttchsts,
  String? tinsdat,
  String? tinsusr,
  dynamic tupdusr,
  dynamic tupddat,
  dynamic tctycod,
  dynamic tctgcod,
  dynamic ttchsms,
}) => ActiveTechniciansModel(  techid: techid ?? _techid,
  ttchcod: ttchcod ?? _ttchcod,
  ttchdsc: ttchdsc ?? _ttchdsc,
  tadd001: tadd001 ?? _tadd001,
  tadd002: tadd002 ?? _tadd002,
  tphnnum: tphnnum ?? _tphnnum,
  tmobnum: tmobnum ?? _tmobnum,
  temladd: temladd ?? _temladd,
  tnicnum: tnicnum ?? _tnicnum,
  ttchint: ttchint ?? _ttchint,
  tlatval: tlatval ?? _tlatval,
  tlngval: tlngval ?? _tlngval,
  ttchsts: ttchsts ?? _ttchsts,
  tinsdat: tinsdat ?? _tinsdat,
  tinsusr: tinsusr ?? _tinsusr,
  tupdusr: tupdusr ?? _tupdusr,
  tupddat: tupddat ?? _tupddat,
  tctycod: tctycod ?? _tctycod,
  tctgcod: tctgcod ?? _tctgcod,
  ttchsms: ttchsms ?? _ttchsms,
);
  String? get techid => _techid;
  String? get ttchcod => _ttchcod;
  String? get ttchdsc => _ttchdsc;
  String? get tadd001 => _tadd001;
  String? get tadd002 => _tadd002;
  String? get tphnnum => _tphnnum;
  String? get tmobnum => _tmobnum;
  String? get temladd => _temladd;
  dynamic get tnicnum => _tnicnum;
  dynamic get ttchint => _ttchint;
  dynamic get tlatval => _tlatval;
  dynamic get tlngval => _tlngval;
  String? get ttchsts => _ttchsts;
  String? get tinsdat => _tinsdat;
  String? get tinsusr => _tinsusr;
  dynamic get tupdusr => _tupdusr;
  dynamic get tupddat => _tupddat;
  dynamic get tctycod => _tctycod;
  dynamic get tctgcod => _tctgcod;
  dynamic get ttchsms => _ttchsms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['techid'] = _techid;
    map['ttchcod'] = _ttchcod;
    map['ttchdsc'] = _ttchdsc;
    map['tadd001'] = _tadd001;
    map['tadd002'] = _tadd002;
    map['tphnnum'] = _tphnnum;
    map['tmobnum'] = _tmobnum;
    map['temladd'] = _temladd;
    map['tnicnum'] = _tnicnum;
    map['ttchint'] = _ttchint;
    map['tlatval'] = _tlatval;
    map['tlngval'] = _tlngval;
    map['ttchsts'] = _ttchsts;
    map['tinsdat'] = _tinsdat;
    map['tinsusr'] = _tinsusr;
    map['tupdusr'] = _tupdusr;
    map['tupddat'] = _tupddat;
    map['tctycod'] = _tctycod;
    map['tctgcod'] = _tctgcod;
    map['ttchsms'] = _ttchsms;
    return map;
  }

}