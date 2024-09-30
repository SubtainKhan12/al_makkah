import 'dart:convert';
/// Job# : "000013"
/// Date : "2024-09-22"
/// Technician : "ABRAR"
/// Customer : "SAKHAWT ALI"
/// Mobile : "03007251437"
/// Amount : "1000.00"
/// Collection : "0"
/// Col Date : ""

GetCollectionModel getCollectionModelFromJson(String str) => GetCollectionModel.fromJson(json.decode(str));
String getCollectionModelToJson(GetCollectionModel data) => json.encode(data.toJson());
class GetCollectionModel {
  GetCollectionModel({
      String? job, 
      String? date, 
      String? technician, 
      String? customer, 
      String? mobile, 
      String? amount, 
      String? collection, 
      String? colDate,}){
    _job = job;
    _date = date;
    _technician = technician;
    _customer = customer;
    _mobile = mobile;
    _amount = amount;
    _collection = collection;
    _colDate = colDate;
}

  GetCollectionModel.fromJson(dynamic json) {
    _job = json['Job#'];
    _date = json['Date'];
    _technician = json['Technician'];
    _customer = json['Customer'];
    _mobile = json['Mobile'];
    _amount = json['Amount'];
    _collection = json['Collection'];
    _colDate = json['Col Date'];
  }
  String? _job;
  String? _date;
  String? _technician;
  String? _customer;
  String? _mobile;
  String? _amount;
  String? _collection;
  String? _colDate;
GetCollectionModel copyWith({  String? job,
  String? date,
  String? technician,
  String? customer,
  String? mobile,
  String? amount,
  String? collection,
  String? colDate,
}) => GetCollectionModel(  job: job ?? _job,
  date: date ?? _date,
  technician: technician ?? _technician,
  customer: customer ?? _customer,
  mobile: mobile ?? _mobile,
  amount: amount ?? _amount,
  collection: collection ?? _collection,
  colDate: colDate ?? _colDate,
);
  String? get job => _job;
  String? get date => _date;
  String? get technician => _technician;
  String? get customer => _customer;
  String? get mobile => _mobile;
  String? get amount => _amount;
  String? get collection => _collection;
  String? get colDate => _colDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Job#'] = _job;
    map['Date'] = _date;
    map['Technician'] = _technician;
    map['Customer'] = _customer;
    map['Mobile'] = _mobile;
    map['Amount'] = _amount;
    map['Collection'] = _collection;
    map['Col Date'] = _colDate;
    return map;
  }

}