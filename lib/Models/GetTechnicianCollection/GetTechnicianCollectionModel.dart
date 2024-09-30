import 'dart:convert';
/// Job# : "000014"
/// Date : "2024-09-22"
/// Technician : "ASHIQ HUSSAIN"
/// Customer : ",,,,,"
/// Mobile : "03464700730"
/// Amount : "200.00"

GetTechnicianCollectionModel getTechnicianCollectionModelFromJson(String str) => GetTechnicianCollectionModel.fromJson(json.decode(str));
String getTechnicianCollectionModelToJson(GetTechnicianCollectionModel data) => json.encode(data.toJson());
class GetTechnicianCollectionModel {
  GetTechnicianCollectionModel({
      String? job, 
      String? date, 
      String? technician, 
      String? customer, 
      String? mobile, 
      String? amount,}){
    _job = job;
    _date = date;
    _technician = technician;
    _customer = customer;
    _mobile = mobile;
    _amount = amount;
}

  GetTechnicianCollectionModel.fromJson(dynamic json) {
    _job = json['Job#'];
    _date = json['Date'];
    _technician = json['Technician'];
    _customer = json['Customer'];
    _mobile = json['Mobile'];
    _amount = json['Amount'];
  }
  String? _job;
  String? _date;
  String? _technician;
  String? _customer;
  String? _mobile;
  String? _amount;
GetTechnicianCollectionModel copyWith({  String? job,
  String? date,
  String? technician,
  String? customer,
  String? mobile,
  String? amount,
}) => GetTechnicianCollectionModel(  job: job ?? _job,
  date: date ?? _date,
  technician: technician ?? _technician,
  customer: customer ?? _customer,
  mobile: mobile ?? _mobile,
  amount: amount ?? _amount,
);
  String? get job => _job;
  String? get date => _date;
  String? get technician => _technician;
  String? get customer => _customer;
  String? get mobile => _mobile;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Job#'] = _job;
    map['Date'] = _date;
    map['Technician'] = _technician;
    map['Customer'] = _customer;
    map['Mobile'] = _mobile;
    map['Amount'] = _amount;
    return map;
  }

}