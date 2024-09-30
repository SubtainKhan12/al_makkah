import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../../APIs/apis.dart';
import '../../../../Models/GetTechnicianCollection/GetTechnicianCollectionModel.dart';
import '../../../../Models/TechnicianComparison/TechnicianComparisonModel.dart';
import '../../../../Utilities/Colors/colors.dart';
import '../../../../Utilities/Loader/loader.dart';
import '../../../../Utilities/Snackbar/snackbar.dart';

class TechnicianCollectionUI extends StatefulWidget {
  TechnicianComparisonModel technicianComparison;

  TechnicianCollectionUI({super.key, required this.technicianComparison});

  @override
  State<TechnicianCollectionUI> createState() => _TechnicianCollectionUIState();
}

class _TechnicianCollectionUIState extends State<TechnicianCollectionUI> {
  TextEditingController _amountController = TextEditingController();
  List<GetTechnicianCollectionModel> technicianCollectionList = [];
  List<GetTechnicianCollectionModel> searchTechnicianCollectionList = [];
  bool loading = true;
  var cdate = DateFormat("dd-MM-yyyy").format(DateTime.now());

  @override
  void initState() {
    super.initState();
    Post_GetTechnicianCollection();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Technician Collection',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.baigeColor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: RefreshIndicator(
          onRefresh: Post_GetTechnicianCollection,
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  search(value);
                },
                decoration: InputDecoration(
                  hintText: "Search...",
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: loading
                    ? Center(child: CircularProgressIndicator())
                    : searchTechnicianCollectionList.isEmpty
                        ? Center(
                            child: Text(
                            "No Application is Installed",
                            style: TextStyle(
                                fontSize: _height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ))
                        : ListView.builder(
                            itemCount: searchTechnicianCollectionList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  _saveCollectionDialogue(
                                      searchTechnicianCollectionList[index]);
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              searchTechnicianCollectionList[
                                                      index]
                                                  .job
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: _height * 0.017,
                                                  color: Color(0xffF58634),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              '  -  ',
                                              style: TextStyle(
                                                  fontSize: _height * 0.017,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              DateFormat('dd-MM-yyyy').format(
                                                  DateTime.parse(
                                                      searchTechnicianCollectionList[
                                                              index]
                                                          .date
                                                          .toString())),
                                              style: TextStyle(
                                                  fontSize: _height * 0.017,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          searchTechnicianCollectionList[index]
                                              .customer
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: _height * 0.015,
                                          ),
                                        ),
                                        Text(
                                          searchTechnicianCollectionList[index]
                                              .mobile
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: _height * 0.015,
                                          ),
                                        ),
                                        Text(
                                          '${searchTechnicianCollectionList[index].amount.toString()} PKR',
                                          style: TextStyle(
                                              fontSize: _height * 0.017,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveCollectionDialogue(GetTechnicianCollectionModel model) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    setAmountData() {
      _amountController.text = model.amount.toString() ?? '';
    }

    setAmountData();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Save Collection',
                style: TextStyle(color: ColorsUtils.appcolor),
              ),
              Text(
                cdate,
                style: TextStyle(
                    fontSize: _height * 0.017,
                    fontWeight: FontWeight.w500,
                    color: ColorsUtils.lightblueColor),
              ),
            ],
          ),
          content: Container(
            height: _height * 0.23,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    'Job# : ${model.job.toString()}',
                    style: TextStyle(
                        fontSize: _height * 0.015, fontWeight: FontWeight.w500),
                  ),
                ),
                Flexible(
                  child: Text(
                    'Customer : ${model.customer.toString()}',
                    style: TextStyle(
                        fontSize: _height * 0.015, fontWeight: FontWeight.w500),
                  ),
                ),
                Flexible(
                  child: Text(
                    'Technician : ${model.technician.toString()}',
                    style: TextStyle(
                        fontSize: _height * 0.015, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextFormField(
                  controller: _amountController,
                  readOnly: true,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                Container(
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () {
                          CircularIndicator.showLoader(context);
                          Post_SaveCollection(model); // Pass the model here
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: _height * 0.018),
                        )))
              ],
            ),
          ),
        );
      },
    );
  }

  Future Post_SaveCollection(GetTechnicianCollectionModel model) async {
    var response = await http.post(Uri.parse(SaveCollection), body: {
      'FJobNum': model.job.toString(),
      'FColAmt': _amountController.text,
      'FColDat': cdate.toString(),
    });
    var result = jsonDecode(response.body);
    if (result['error'] == 200) {
      Snackbar.showSnackBar(context, result['message'], Colors.teal);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Snackbar.showSnackBar(context, result['message'], Colors.teal);
      Navigator.pop(context);
    }
  }

  Future Post_GetTechnicianCollection() async {
    var response = await http.post(Uri.parse(GetTechnicianCollection), body: {
      'FTchCod': widget.technicianComparison.ttchcod.toString(),
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(cdate);

      setState(() {
        loading = false;
      });
      technicianCollectionList.clear();
      for (Map i in result) {
        technicianCollectionList.add(GetTechnicianCollectionModel.fromJson(i));
      }
      setState(() {
        searchTechnicianCollectionList = List.from(technicianCollectionList);
      });
    } else {
      setState(() {
        loading = false; // Update loading state in case of an error
      });
    }
  }

  void search(String query) {
    setState(() {
      searchTechnicianCollectionList =
          technicianCollectionList.where((category) {
        final customerNameMatches =
            category.customer?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        final mobileNumberMatches =
            category.mobile?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        final complainNumberMatches =
            category.job?.toLowerCase().contains(query.toLowerCase()) ?? false;
        return customerNameMatches ||
            mobileNumberMatches ||
            complainNumberMatches;
      }).toList();
    });
  }
}
