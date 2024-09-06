import 'dart:convert';
/// id : "2"
/// tjobnum : "000002"
/// tjobdat : "2024-08-26"
/// tjobtim : "05:48:39"
/// tjobtyp : "REPAIRING"
/// tjobsts : "C"
/// tmobnum : "03023244304"
/// tcstnam : "BILAL ALI"
/// tadd001 : "NOOR SHAH ROAD 50/3R"
/// tadd002 : "."
/// tphnnum : "03023244304"
/// temladd : "BILALALI@GMAIL.COM"
/// tnicnum : "0000000000000"
/// tctycod : "001"
/// tcmpcod : "001"
/// tctgcod : "001"
/// titmdsc : "FREEZER"
/// tcptcod : "001"
/// trefcod : "001"
/// tinvnum : "2222222"
/// tpurdat : "2024-06-05"
/// twrnsts : ""
/// tjobrem : "THIS COMPLAIN IS FOR BILAL SAHAB"
/// ttchcod : "001"
/// tfwddat : "2024-09-05"
/// tfwdtim : "14:16:58"
/// trefnum : "null"
/// titmser : "54646445645"
/// tdat001 : "2024-09-06"
/// tdat002 : null
/// tdat003 : null
/// tdat004 : null
/// trem001 : "KAL CHECK KRWANA HAI "
/// trem002 : null
/// trem003 : null
/// trem004 : null
/// tinsdat : "2024-08-26"
/// tinsusr : "74"
/// tupddat : null
/// tupdusr : null
/// tclsdat : "2024-08-29"
/// tjobamt : "550.00"
/// tclsrem : "LGA DIA HAI "
/// Company : "HAIR"
/// Category : "FREEZER"
/// Technician : "IRFAN"
/// Mobile : "03053421934"
/// City : "OKARA"

JobInfoModel jobInfoModelFromJson(String str) => JobInfoModel.fromJson(json.decode(str));
String jobInfoModelToJson(JobInfoModel data) => json.encode(data.toJson());
class JobInfoModel {
  JobInfoModel({
      String? id, 
      String? tjobnum, 
      String? tjobdat, 
      String? tjobtim, 
      String? tjobtyp, 
      String? tjobsts, 
      String? tmobnum, 
      String? tcstnam, 
      String? tadd001, 
      String? tadd002, 
      String? tphnnum, 
      String? temladd, 
      String? tnicnum, 
      String? tctycod, 
      String? tcmpcod, 
      String? tctgcod, 
      String? titmdsc, 
      String? tcptcod, 
      String? trefcod, 
      String? tinvnum, 
      String? tpurdat, 
      String? twrnsts, 
      String? tjobrem, 
      String? ttchcod, 
      String? tfwddat, 
      String? tfwdtim, 
      String? trefnum, 
      String? titmser, 
      String? tdat001, 
      dynamic tdat002, 
      dynamic tdat003, 
      dynamic tdat004, 
      String? trem001, 
      dynamic trem002, 
      dynamic trem003, 
      dynamic trem004, 
      String? tinsdat, 
      String? tinsusr, 
      dynamic tupddat, 
      dynamic tupdusr, 
      String? tclsdat, 
      String? tjobamt, 
      String? tclsrem, 
      String? company, 
      String? category, 
      String? technician, 
      String? mobile, 
      String? city,}){
    _id = id;
    _tjobnum = tjobnum;
    _tjobdat = tjobdat;
    _tjobtim = tjobtim;
    _tjobtyp = tjobtyp;
    _tjobsts = tjobsts;
    _tmobnum = tmobnum;
    _tcstnam = tcstnam;
    _tadd001 = tadd001;
    _tadd002 = tadd002;
    _tphnnum = tphnnum;
    _temladd = temladd;
    _tnicnum = tnicnum;
    _tctycod = tctycod;
    _tcmpcod = tcmpcod;
    _tctgcod = tctgcod;
    _titmdsc = titmdsc;
    _tcptcod = tcptcod;
    _trefcod = trefcod;
    _tinvnum = tinvnum;
    _tpurdat = tpurdat;
    _twrnsts = twrnsts;
    _tjobrem = tjobrem;
    _ttchcod = ttchcod;
    _tfwddat = tfwddat;
    _tfwdtim = tfwdtim;
    _trefnum = trefnum;
    _titmser = titmser;
    _tdat001 = tdat001;
    _tdat002 = tdat002;
    _tdat003 = tdat003;
    _tdat004 = tdat004;
    _trem001 = trem001;
    _trem002 = trem002;
    _trem003 = trem003;
    _trem004 = trem004;
    _tinsdat = tinsdat;
    _tinsusr = tinsusr;
    _tupddat = tupddat;
    _tupdusr = tupdusr;
    _tclsdat = tclsdat;
    _tjobamt = tjobamt;
    _tclsrem = tclsrem;
    _company = company;
    _category = category;
    _technician = technician;
    _mobile = mobile;
    _city = city;
}

  JobInfoModel.fromJson(dynamic json) {
    _id = json['id'];
    _tjobnum = json['tjobnum'];
    _tjobdat = json['tjobdat'];
    _tjobtim = json['tjobtim'];
    _tjobtyp = json['tjobtyp'];
    _tjobsts = json['tjobsts'];
    _tmobnum = json['tmobnum'];
    _tcstnam = json['tcstnam'];
    _tadd001 = json['tadd001'];
    _tadd002 = json['tadd002'];
    _tphnnum = json['tphnnum'];
    _temladd = json['temladd'];
    _tnicnum = json['tnicnum'];
    _tctycod = json['tctycod'];
    _tcmpcod = json['tcmpcod'];
    _tctgcod = json['tctgcod'];
    _titmdsc = json['titmdsc'];
    _tcptcod = json['tcptcod'];
    _trefcod = json['trefcod'];
    _tinvnum = json['tinvnum'];
    _tpurdat = json['tpurdat'];
    _twrnsts = json['twrnsts'];
    _tjobrem = json['tjobrem'];
    _ttchcod = json['ttchcod'];
    _tfwddat = json['tfwddat'];
    _tfwdtim = json['tfwdtim'];
    _trefnum = json['trefnum'];
    _titmser = json['titmser'];
    _tdat001 = json['tdat001'];
    _tdat002 = json['tdat002'];
    _tdat003 = json['tdat003'];
    _tdat004 = json['tdat004'];
    _trem001 = json['trem001'];
    _trem002 = json['trem002'];
    _trem003 = json['trem003'];
    _trem004 = json['trem004'];
    _tinsdat = json['tinsdat'];
    _tinsusr = json['tinsusr'];
    _tupddat = json['tupddat'];
    _tupdusr = json['tupdusr'];
    _tclsdat = json['tclsdat'];
    _tjobamt = json['tjobamt'];
    _tclsrem = json['tclsrem'];
    _company = json['Company'];
    _category = json['Category'];
    _technician = json['Technician'];
    _mobile = json['Mobile'];
    _city = json['City'];
  }
  String? _id;
  String? _tjobnum;
  String? _tjobdat;
  String? _tjobtim;
  String? _tjobtyp;
  String? _tjobsts;
  String? _tmobnum;
  String? _tcstnam;
  String? _tadd001;
  String? _tadd002;
  String? _tphnnum;
  String? _temladd;
  String? _tnicnum;
  String? _tctycod;
  String? _tcmpcod;
  String? _tctgcod;
  String? _titmdsc;
  String? _tcptcod;
  String? _trefcod;
  String? _tinvnum;
  String? _tpurdat;
  String? _twrnsts;
  String? _tjobrem;
  String? _ttchcod;
  String? _tfwddat;
  String? _tfwdtim;
  String? _trefnum;
  String? _titmser;
  String? _tdat001;
  dynamic _tdat002;
  dynamic _tdat003;
  dynamic _tdat004;
  String? _trem001;
  dynamic _trem002;
  dynamic _trem003;
  dynamic _trem004;
  String? _tinsdat;
  String? _tinsusr;
  dynamic _tupddat;
  dynamic _tupdusr;
  String? _tclsdat;
  String? _tjobamt;
  String? _tclsrem;
  String? _company;
  String? _category;
  String? _technician;
  String? _mobile;
  String? _city;
JobInfoModel copyWith({  String? id,
  String? tjobnum,
  String? tjobdat,
  String? tjobtim,
  String? tjobtyp,
  String? tjobsts,
  String? tmobnum,
  String? tcstnam,
  String? tadd001,
  String? tadd002,
  String? tphnnum,
  String? temladd,
  String? tnicnum,
  String? tctycod,
  String? tcmpcod,
  String? tctgcod,
  String? titmdsc,
  String? tcptcod,
  String? trefcod,
  String? tinvnum,
  String? tpurdat,
  String? twrnsts,
  String? tjobrem,
  String? ttchcod,
  String? tfwddat,
  String? tfwdtim,
  String? trefnum,
  String? titmser,
  String? tdat001,
  dynamic tdat002,
  dynamic tdat003,
  dynamic tdat004,
  String? trem001,
  dynamic trem002,
  dynamic trem003,
  dynamic trem004,
  String? tinsdat,
  String? tinsusr,
  dynamic tupddat,
  dynamic tupdusr,
  String? tclsdat,
  String? tjobamt,
  String? tclsrem,
  String? company,
  String? category,
  String? technician,
  String? mobile,
  String? city,
}) => JobInfoModel(  id: id ?? _id,
  tjobnum: tjobnum ?? _tjobnum,
  tjobdat: tjobdat ?? _tjobdat,
  tjobtim: tjobtim ?? _tjobtim,
  tjobtyp: tjobtyp ?? _tjobtyp,
  tjobsts: tjobsts ?? _tjobsts,
  tmobnum: tmobnum ?? _tmobnum,
  tcstnam: tcstnam ?? _tcstnam,
  tadd001: tadd001 ?? _tadd001,
  tadd002: tadd002 ?? _tadd002,
  tphnnum: tphnnum ?? _tphnnum,
  temladd: temladd ?? _temladd,
  tnicnum: tnicnum ?? _tnicnum,
  tctycod: tctycod ?? _tctycod,
  tcmpcod: tcmpcod ?? _tcmpcod,
  tctgcod: tctgcod ?? _tctgcod,
  titmdsc: titmdsc ?? _titmdsc,
  tcptcod: tcptcod ?? _tcptcod,
  trefcod: trefcod ?? _trefcod,
  tinvnum: tinvnum ?? _tinvnum,
  tpurdat: tpurdat ?? _tpurdat,
  twrnsts: twrnsts ?? _twrnsts,
  tjobrem: tjobrem ?? _tjobrem,
  ttchcod: ttchcod ?? _ttchcod,
  tfwddat: tfwddat ?? _tfwddat,
  tfwdtim: tfwdtim ?? _tfwdtim,
  trefnum: trefnum ?? _trefnum,
  titmser: titmser ?? _titmser,
  tdat001: tdat001 ?? _tdat001,
  tdat002: tdat002 ?? _tdat002,
  tdat003: tdat003 ?? _tdat003,
  tdat004: tdat004 ?? _tdat004,
  trem001: trem001 ?? _trem001,
  trem002: trem002 ?? _trem002,
  trem003: trem003 ?? _trem003,
  trem004: trem004 ?? _trem004,
  tinsdat: tinsdat ?? _tinsdat,
  tinsusr: tinsusr ?? _tinsusr,
  tupddat: tupddat ?? _tupddat,
  tupdusr: tupdusr ?? _tupdusr,
  tclsdat: tclsdat ?? _tclsdat,
  tjobamt: tjobamt ?? _tjobamt,
  tclsrem: tclsrem ?? _tclsrem,
  company: company ?? _company,
  category: category ?? _category,
  technician: technician ?? _technician,
  mobile: mobile ?? _mobile,
  city: city ?? _city,
);
  String? get id => _id;
  String? get tjobnum => _tjobnum;
  String? get tjobdat => _tjobdat;
  String? get tjobtim => _tjobtim;
  String? get tjobtyp => _tjobtyp;
  String? get tjobsts => _tjobsts;
  String? get tmobnum => _tmobnum;
  String? get tcstnam => _tcstnam;
  String? get tadd001 => _tadd001;
  String? get tadd002 => _tadd002;
  String? get tphnnum => _tphnnum;
  String? get temladd => _temladd;
  String? get tnicnum => _tnicnum;
  String? get tctycod => _tctycod;
  String? get tcmpcod => _tcmpcod;
  String? get tctgcod => _tctgcod;
  String? get titmdsc => _titmdsc;
  String? get tcptcod => _tcptcod;
  String? get trefcod => _trefcod;
  String? get tinvnum => _tinvnum;
  String? get tpurdat => _tpurdat;
  String? get twrnsts => _twrnsts;
  String? get tjobrem => _tjobrem;
  String? get ttchcod => _ttchcod;
  String? get tfwddat => _tfwddat;
  String? get tfwdtim => _tfwdtim;
  String? get trefnum => _trefnum;
  String? get titmser => _titmser;
  String? get tdat001 => _tdat001;
  dynamic get tdat002 => _tdat002;
  dynamic get tdat003 => _tdat003;
  dynamic get tdat004 => _tdat004;
  String? get trem001 => _trem001;
  dynamic get trem002 => _trem002;
  dynamic get trem003 => _trem003;
  dynamic get trem004 => _trem004;
  String? get tinsdat => _tinsdat;
  String? get tinsusr => _tinsusr;
  dynamic get tupddat => _tupddat;
  dynamic get tupdusr => _tupdusr;
  String? get tclsdat => _tclsdat;
  String? get tjobamt => _tjobamt;
  String? get tclsrem => _tclsrem;
  String? get company => _company;
  String? get category => _category;
  String? get technician => _technician;
  String? get mobile => _mobile;
  String? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['tjobnum'] = _tjobnum;
    map['tjobdat'] = _tjobdat;
    map['tjobtim'] = _tjobtim;
    map['tjobtyp'] = _tjobtyp;
    map['tjobsts'] = _tjobsts;
    map['tmobnum'] = _tmobnum;
    map['tcstnam'] = _tcstnam;
    map['tadd001'] = _tadd001;
    map['tadd002'] = _tadd002;
    map['tphnnum'] = _tphnnum;
    map['temladd'] = _temladd;
    map['tnicnum'] = _tnicnum;
    map['tctycod'] = _tctycod;
    map['tcmpcod'] = _tcmpcod;
    map['tctgcod'] = _tctgcod;
    map['titmdsc'] = _titmdsc;
    map['tcptcod'] = _tcptcod;
    map['trefcod'] = _trefcod;
    map['tinvnum'] = _tinvnum;
    map['tpurdat'] = _tpurdat;
    map['twrnsts'] = _twrnsts;
    map['tjobrem'] = _tjobrem;
    map['ttchcod'] = _ttchcod;
    map['tfwddat'] = _tfwddat;
    map['tfwdtim'] = _tfwdtim;
    map['trefnum'] = _trefnum;
    map['titmser'] = _titmser;
    map['tdat001'] = _tdat001;
    map['tdat002'] = _tdat002;
    map['tdat003'] = _tdat003;
    map['tdat004'] = _tdat004;
    map['trem001'] = _trem001;
    map['trem002'] = _trem002;
    map['trem003'] = _trem003;
    map['trem004'] = _trem004;
    map['tinsdat'] = _tinsdat;
    map['tinsusr'] = _tinsusr;
    map['tupddat'] = _tupddat;
    map['tupdusr'] = _tupdusr;
    map['tclsdat'] = _tclsdat;
    map['tjobamt'] = _tjobamt;
    map['tclsrem'] = _tclsrem;
    map['Company'] = _company;
    map['Category'] = _category;
    map['Technician'] = _technician;
    map['Mobile'] = _mobile;
    map['City'] = _city;
    return map;
  }

}