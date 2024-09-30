import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../../APIs/apis.dart';
import '../../../../Models/GetCollectionModel.dart';
import '../../../../Utilities/Colors/colors.dart';

class GetCollectionUI extends StatefulWidget {
  const GetCollectionUI({super.key});

  @override
  State<GetCollectionUI> createState() => _GetCollectionUIState();
}

class _GetCollectionUIState extends State<GetCollectionUI> {
  List<GetCollectionModel> getCollectionList = [];
  List<GetCollectionModel> filtreGetCollectionList = [];
  DateTime selectedInitialDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime selectedFinalDate = DateTime.now();
  double tableFontSize = 12;
  var f = NumberFormat("###,###.#", "en_US");
  final numberFormat = NumberFormat('#,###');

  String formatCollection(String amount) {
    final doubleAmount = double.tryParse(amount) ?? 0.00;
    return numberFormat.format(doubleAmount);
  }

  String? technicians;
  String? status;
  String? FRepTyp;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Collection Report',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        centerTitle: true,
        backgroundColor: ColorsUtils.baigeColor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: RefreshIndicator(
        onRefresh: post_GetCollection,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: ColorsUtils.lightBeige,
                      ),
                      child: Center(
                          child: Text(
                        "Collection Reports",
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorsUtils.whiteColor,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () => _intSelectDate(context, setState),
                              child: Row(
                                children: [
                                  SizedBox(width: 8),
                                  Text('From: ',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                  Text(
                                    DateFormat('dd-MM-yyyy')
                                        .format(selectedInitialDate),
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Icon(Icons.calendar_today, color: Colors.green),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: _width * 0.35,
                            height: _height * 0.04,
                            child: DropdownButtonFormField<String>(
                              value: status, // Ensure this has a default value before rendering
                              onChanged: (newValue) {
                                setState(() {
                                  status = newValue!;
                                });
                              },
                              items: <String>[
                                'ALL',
                                'O/S',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: _height * 0.015),
                                  ),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: "Status",
                                contentPadding: EdgeInsets.symmetric(horizontal: 10), // Add padding inside the dropdown
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  borderSide: const BorderSide(
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 5, horizontal: 5),
                          //   child: Container(
                          //     width: MediaQuery.of(context).size.width * 0.41,
                          //     height: MediaQuery.of(context).size.height * 0.03,
                          //     child: DropdownButtonFormField<String>(
                          //       value: technicians,
                          //       onChanged: (newValue) {
                          //         setState(() {
                          //           technicians = newValue;
                          //         });
                          //       },
                          //       items: activeTechniciansList.map((technician) {
                          //         return DropdownMenuItem<String>(
                          //           value: technician.ttchcod ?? '',
                          //           child: Text(
                          //             technician.ttchdsc ?? '',
                          //             style: TextStyle(
                          //                 fontSize:
                          //                 MediaQuery.of(context).size.height *
                          //                     0.018,
                          //                 // Adjust font size based on height
                          //                 overflow: TextOverflow.ellipsis,
                          //                 color: Colors.black),
                          //             maxLines: 1,
                          //           ),
                          //         );
                          //       }).toList(),
                          //       isDense: true,
                          //       // Make the dropdown more compact
                          //       decoration: InputDecoration(
                          //         labelText: "Technician",
                          //         labelStyle: TextStyle(
                          //           fontSize: MediaQuery.of(context).size.height *
                          //               0.018, // Adjust label font size
                          //         ),
                          //         border: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(3),
                          //           borderSide: const BorderSide(
                          //             color: Colors.black,
                          //           ),
                          //         ),
                          //         contentPadding: EdgeInsets.symmetric(
                          //             horizontal:
                          //             10), // Add padding inside the text field
                          //       ),
                          //       style: TextStyle(
                          //         fontSize:
                          //         MediaQuery.of(context).size.height * 0.018,
                          //         // Adjust font size for selected value
                          //         overflow: TextOverflow
                          //             .ellipsis, // Ensure selected value fits within the field
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              _fnlSelectDate(context, setState);
                            },
                            child: Row(
                              children: [
                                SizedBox(width: 8),
                                Text(
                                  '     To: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(selectedFinalDate),
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(Icons.calendar_today, color: Colors.blue),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            height: _height * 0.035,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsUtils.baigeColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5), // Makes the button rectangular
                                  ),
                                ),
                                onPressed: () {
                                  post_GetCollection();
                                },
                                child: Text(
                                  'Submit',
                                  style:
                                      TextStyle(color: ColorsUtils.whiteColor),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _height * 0.005,
                    ),
                  ],
                ),
              ),
              Column(children: [
                Table(
                  border: TableBorder(
                    verticalInside: BorderSide(width: 1, color: Colors.grey),
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1.5),
                    2: FlexColumnWidth(1.5),
                    3: FlexColumnWidth(0.8),
                    4: FlexColumnWidth(0.8),
                    5: FlexColumnWidth(1.3),
                  },
                  children: [
                    TableRow(
                      // Header row
                      decoration: BoxDecoration(
                          color: ColorsUtils.lightBeige,
                          border: Border.all(width: 0.5)),
                      children: [
                        TableCell(
                          child: Center(
                            child: Text('Job#',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Customer',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Tch',
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Amt',
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Col',
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Col Date',
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    for (var i = 0;
                        i < (filtreGetCollectionList.length ?? 0);
                        i++)
                      TableRow(
                        // Header row
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.grey)),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0, left: 1),
                              child: Text(
                                  filtreGetCollectionList[i].job.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: tableFontSize,
                                  )),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0, left: 1),
                              child: Text(
                                filtreGetCollectionList[i].customer.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: tableFontSize,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0, left: 1),
                              child: Text(
                                filtreGetCollectionList[i]
                                    .technician
                                    .toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: tableFontSize,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 3.0, right: 1),
                              child: Text(
                                  formatCollection(
                                    filtreGetCollectionList[i]
                                        .amount
                                        .toString(),
                                  ),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: tableFontSize,
                                  )),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 3.0, right: 1),
                              child: Text(
                                  formatCollection(
                                    filtreGetCollectionList[i]
                                        .collection
                                        .toString(),
                                  ),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: tableFontSize,
                                  )),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 3.0, right: 1),
                              child: Text(

                                    filtreGetCollectionList[i]
                                        .colDate
                                        .toString(),

                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: tableFontSize,
                                  )),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> _intSelectDate(
      BuildContext context, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: 'From Date',
      initialDate: selectedInitialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedInitialDate) {
      setState(() {
        selectedInitialDate = picked;
      });
    }
  }

  Future<void> _fnlSelectDate(
      BuildContext context, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: 'To Date',
      initialDate: selectedFinalDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedFinalDate) {
      setState(() {
        selectedFinalDate = picked;
      });
    }
  }

  Future post_GetCollection() async {


    if (status == 'ALL') {
      FRepTyp = '';
    } else if (status == 'O/S') {
      FRepTyp = 'O';
    } else {
      print('No FRepTyp');
    }
    var response = await http.post(Uri.parse(GetCollection), body: {
      'FIntDat': selectedInitialDate.toString(),
      'FFnlDat': selectedFinalDate.toString(),
      'FRepTyp': FRepTyp.toString(),
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      getCollectionList.clear();
      for (Map i in result) {
        getCollectionList.add(GetCollectionModel.fromJson(i));
      }

      setState(() {
        filtreGetCollectionList = getCollectionList;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}
