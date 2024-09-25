import 'dart:convert';

import 'package:al_makkah/Utilities/Colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../../APIs/apis.dart';
import '../../../../Models/ActiveTechnicians/ActiveTechniciansModel.dart';
import '../../../../Models/DailyJobReport/DailyJobReportModel.dart';

class DailyJobReport extends StatefulWidget {
  const DailyJobReport({super.key});

  @override
  State<DailyJobReport> createState() => _DailyJobReportState();
}

class _DailyJobReportState extends State<DailyJobReport> {
  List<ActiveTechniciansModel> activeTechniciansList = [];
  List<DailyJobReportModel> dailyJobReport = [];
  List<DailyJobReportModel> filtreDailyJobReport = [];
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

  double calculateTotalAmount() {
    return filtreDailyJobReport.fold(0.0, (sum, item) {
      // Check if tjobamt is null, if so, treat it as 0.0
      double amount = double.tryParse(item.tjobamt ?? '0') ?? 0.0;
      return sum + amount;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_ActiveTechnicians();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Sale Report',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        centerTitle: true,
        backgroundColor: ColorsUtils.baigeColor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: RefreshIndicator(
        onRefresh: post_CollectionRegister,
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
                        "Sale Reports",
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorsUtils.whiteColor,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: MediaQuery.of(context).size.height * 0.03,
                            child: DropdownButtonFormField<String>(
                              value: technicians,
                              onChanged: (newValue) {
                                setState(() {
                                  technicians = newValue;
                                });
                              },
                              items: activeTechniciansList.map((technician) {
                                return DropdownMenuItem<String>(
                                  value: technician.ttchcod ?? '',
                                  child: Text(
                                    technician.ttchdsc ?? '',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.018,
                                        // Adjust font size based on height
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black),
                                    maxLines: 1,
                                  ),
                                );
                              }).toList(),
                              isDense: true,
                              // Make the dropdown more compact
                              decoration: InputDecoration(
                                labelText: "Technician",
                                labelStyle: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018, // Adjust label font size
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal:
                                        10), // Add padding inside the text field
                              ),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                                // Adjust font size for selected value
                                overflow: TextOverflow
                                    .ellipsis, // Ensure selected value fits within the field
                              ),
                            ),
                          ),
                        ),
                      ],
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
                                  post_CollectionRegister();
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
                    0: FlexColumnWidth(0.7),
                    1: FlexColumnWidth(1.5),
                    2: FlexColumnWidth(1.2),
                    3: FlexColumnWidth(0.4),
                    4: FlexColumnWidth(0.8),
                    5: FlexColumnWidth(0.5),
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
                            child: Text('Mobile',
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Sts',
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Amount',
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Days',
                                style: TextStyle(
                                    fontSize: tableFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    for (var i = 0; i < (filtreDailyJobReport.length ?? 0); i++)
                      TableRow(
                        // Header row
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.grey)),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0, left: 1),
                              child: Text(
                                  filtreDailyJobReport[i].tjobnum.toString(),
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
                                  filtreDailyJobReport[i].tcstnam.toString(),
                                  textAlign: TextAlign.left,
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
                                  filtreDailyJobReport[i].mobile.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: tableFontSize,
                                  )),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0, left: 1),
                              child: Text(
                                filtreDailyJobReport[i].tjobsts.toString(),
                                textAlign: TextAlign.center,
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
                                    filtreDailyJobReport[i].tjobamt.toString(),
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
                                    filtreDailyJobReport[i].days.toString(),
                                  ),
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
                  Divider(
                    thickness: 5,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                    'Total Amount: ${formatCollection(calculateTotalAmount().toString())} PKR',
                    style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                                    ),
                                  ),
                  ),
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

  Future post_CollectionRegister() async {
    var response = await http.post(Uri.parse(DailyJobsReport), body: {
      'FIntDat': selectedInitialDate.toString(),
      'FFnlDat': selectedFinalDate.toString(),
      'FTchCod': technicians.toString(),
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      dailyJobReport.clear();
      for (Map i in result) {
        dailyJobReport.add(DailyJobReportModel.fromJson(i));
      }

      setState(() {
        filtreDailyJobReport = dailyJobReport;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future get_ActiveTechnicians() async {
    var response = await http.post(Uri.parse(GetActiveTechnician));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      activeTechniciansList.clear();
      for (Map i in result) {
        activeTechniciansList.add(ActiveTechniciansModel.fromJson(i));
      }
      setState(() {});
    }
  }
// void search(String query) {
//   if (query.isEmpty) {
//     _filteredDetails = collectionsRegisters?.detail;
//   } else {
//     _filteredDetails = collectionsRegisters?.detail?.where((detail) {
//       return detail.customer?.toLowerCase().contains(query.toLowerCase()) ?? false;
//     }).toList();
//   }
//   setState(() {
//   });
// }
}
