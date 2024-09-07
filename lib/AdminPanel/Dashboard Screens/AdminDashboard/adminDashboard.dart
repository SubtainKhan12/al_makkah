import 'dart:convert';
import 'package:al_makkah/AdminPanel/Dashboard%20Screens/InstalledJobs/installedComplains.dart';
import 'package:al_makkah/Models/JobStatus/JobStatusModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../APIs/apis.dart';
import '../../../LoginPages/loginscreen.dart';
import '../../../Models/DailyComparison/DailyComparisonModel.dart';
import '../../../Models/TechnicianComparison/TechnicianComparisonModel.dart';
import '../../../Utilities/Colors/colors.dart';
import '../PendingJobs/pendingComplains.dart';
import '../TechnicianInfo/InstalledComplains.dart';
import '../TechnicianInfo/pendingComplains.dart';
import '../UnassignedJobs/unassignedComplains.dart';

class AdminDashboardUI extends StatefulWidget {
  const AdminDashboardUI({super.key});

  @override
  State<AdminDashboardUI> createState() => _AdminDashboardUIState();
}

class _AdminDashboardUIState extends State<AdminDashboardUI> {
  List<JobStatusModel> jobStatusList = [];
  List<TechnicianComparisonModel> technicianComparisonList = [];
  List<DailyComparisonModel> dailyComparisonList = [];
  String? name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_JobStatus();
    get_TechnicianComparison();
    post_DailyComparison();
    getLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Hello ${name.toString().trim()}',
            style: TextStyle(color: ColorsUtils.whiteColor),
          ),
          backgroundColor: ColorsUtils.baigeColor,
          iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const LoginUI()));
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        // drawer: AdminDrawerUI(),
        body: RefreshIndicator(
          onRefresh: () async {
            get_JobStatus();
            get_JobStatus();
            post_DailyComparison();
          },
          child: ListView.builder(
              itemCount: jobStatusList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UnassignedComplainsUI()));
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: 10,
                              shadowColor: const Color(0xffC4E4FF),
                              child: Container(
                                height: _height * 0.06,
                                width: _width * 0.48,
                                decoration: BoxDecoration(
                                  // color: Color(0xffC4E4FF),
                                  gradient: LinearGradient(colors: [
                                    ColorsUtils.whiteColor,
                                    ColorsUtils.baigeColor
                                  ]),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: _width * 0.03,
                                    ),
                                    Container(
                                      width: _width * 0.22,
                                      child: const Text(
                                        'UnAssigned',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Color(0xffEEEEEE),
                                      thickness: 1,
                                    ),
                                    Container(
                                      width: _width * 0.177,
                                      child: Text(
                                        jobStatusList[index]
                                            .unassigned
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PendingJobsComplainsUI()));
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: 10,
                              shadowColor: const Color(0xffC4E4FF),
                              child: Container(
                                height: _height * 0.06,
                                width: _width * 0.4,
                                decoration: BoxDecoration(
                                  // color: Color(0xffC4E4FF),
                                  gradient: LinearGradient(colors: [
                                    ColorsUtils.whiteColor,
                                    ColorsUtils.baigeColor
                                  ]),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: _width * 0.03,
                                    ),
                                    Container(
                                      width: _width * 0.15,
                                      child: const Text(
                                        'Pending',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Color(0xffEEEEEE),
                                      thickness: 1,
                                    ),
                                    Container(
                                      width: _width * 0.177,
                                      child: Text(
                                        jobStatusList[index].pending.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _height * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InstalledCustomersUI()));
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: 10,
                              shadowColor: const Color(0xffC4E4FF),
                              child: Container(
                                height: _height * 0.06,
                                width: _width * 0.48,
                                decoration: BoxDecoration(
                                  // color: Color(0xffC4E4FF),
                                  gradient: LinearGradient(colors: [
                                    ColorsUtils.whiteColor,
                                    ColorsUtils.baigeColor
                                  ]),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: _width * 0.03,
                                    ),
                                    Container(
                                      width: _width * 0.22,
                                      child: const Text(
                                        'Installed',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Color(0xffEEEEEE),
                                      thickness: 1,
                                    ),
                                    Container(
                                      width: _width * 0.177,
                                      child: Text(
                                        jobStatusList[index]
                                            .installed
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> ClosedInstallationUI()));
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: 10,
                              shadowColor: const Color(0xffC4E4FF),
                              child: Container(
                                height: _height * 0.06,
                                width: _width * 0.4,
                                decoration: BoxDecoration(
                                  // color: Color(0xffC4E4FF),
                                  gradient: LinearGradient(colors: [
                                    ColorsUtils.whiteColor,
                                    ColorsUtils.baigeColor
                                  ]),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: _width * 0.03,
                                    ),
                                    Container(
                                      width: _width * 0.15,
                                      child: const Text(
                                        'Closed',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Color(0xffEEEEEE),
                                      thickness: 1,
                                    ),
                                    Container(
                                      width: _width * 0.177,
                                      child: Text(
                                        jobStatusList[index].closed.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _height * 0.005,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => CanceledInstallationUI()));
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(5),
                            elevation: 10,
                            shadowColor: const Color(0xffC4E4FF),
                            child: Container(
                              height: _height * 0.06,
                              width: _width * 0.48,
                              decoration: BoxDecoration(
                                // color: Color(0xffC4E4FF),
                                gradient: LinearGradient(colors: [
                                  ColorsUtils.whiteColor,
                                  ColorsUtils.baigeColor
                                ]),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: _width * 0.03,
                                  ),
                                  Container(
                                    width: _width * 0.22,
                                    child: const Text(
                                      'Canceled',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Color(0xffEEEEEE),
                                    thickness: 1,
                                  ),
                                  Container(
                                    width: _width * 0.177,
                                    child: Text(
                                      jobStatusList[index].cancelled.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      Text(
                        '  4 Days Info:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: ColorsUtils.redColor),
                      ),
                      ListView.builder(
                        itemCount: dailyComparisonList.length,
                        shrinkWrap: true,
                        // Allow the ListView to shrink to fit its children
                        physics: const NeverScrollableScrollPhysics(),
                        // Disable scrolling for the inner ListView
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 10,
                            child: Container(
                              height: _height * 0.05,
                              width: _width * 1,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                ColorsUtils.whiteColor,
                                ColorsUtils.baigeColor,
                              ])),
                              child: Row(
                                children: [
                                  Container(
                                    width: _width * 0.15,
                                    child: Text(
                                      '   ${dailyComparisonList[index].date.toString().trim()}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: _width * 0.25,
                                    child: Text(
                                      dailyComparisonList[index]
                                          .day
                                          .toString()
                                          .trim(),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: _width * 0.1,
                                    child: Text(
                                      dailyComparisonList[index]
                                          .jobs
                                          .toString()
                                          .trim(),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: _width * 0.1,
                                    child: Text(
                                      dailyComparisonList[index]
                                          .pending
                                          .toString()
                                          .trim(),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: _width * 0.1,
                                    child: Text(
                                      dailyComparisonList[index]
                                          .installed
                                          .toString()
                                          .trim(),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Text(
                        '  Technician info:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: ColorsUtils.redColor),
                      ),
                      ListView.builder(
                        itemCount: technicianComparisonList.length,
                        shrinkWrap: true,
                        // Allow the ListView to shrink to fit its children
                        physics: const NeverScrollableScrollPhysics(),
                        // Disable scrolling for the inner ListView
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => _buildBottomSheet(
                                    context, technicianComparisonList[index]),
                              );
                            },
                            child: Card(
                              child: Container(
                                height: _height * 0.05,
                                width: _width * 1,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                  ColorsUtils.whiteColor,
                                  ColorsUtils.baigeColor,
                                ])),
                                child: Row(
                                  children: [
                                    Container(
                                      width: _width * 0.47,
                                      child: Text(
                                        '   ${technicianComparisonList[index].name.toString().trim()}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: _width * 0.1,
                                      child: Text(
                                        technicianComparisonList[index]
                                            .assigned
                                            .toString()
                                            .trim(),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: _width * 0.1,
                                      child: Text(
                                        technicianComparisonList[index]
                                            .pending
                                            .toString()
                                            .trim(),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: _width * 0.1,
                                      child: Text(
                                        technicianComparisonList[index]
                                            .installed
                                            .toString()
                                            .trim(),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
        ));
  }

  Widget _buildBottomSheet(
      BuildContext context, TechnicianComparisonModel model) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.35,
            maxChildSize: 0.9,
            minChildSize: 0.3,
            builder: (_, controller) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: ListView(
                      controller: controller,
                      children: [
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            model.name.toString().trim(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            _showPhoneDialog(model.mobile.toString());
                          },
                          child: Text(
                            model.mobile.toString().trim(),
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: ColorsUtils.redColor,
                              decorationThickness: 2,
                              fontSize: 16,
                              color: ColorsUtils.redColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PendingComplainsUI(
                                          technicianComparison: model,
                                        )));
                          },
                          child: const ListTile(
                            leading: Icon(Icons.pending),
                            title: Text("Pending Complains"),
                            // subtitle: Text("Customer CMP: ${model.cmp}"),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InstalledComplainsUI(
                                          technicianComparison: model,
                                        )));
                          },
                          child: const ListTile(
                            leading: Icon(Icons.input),
                            title: Text("Installed Complains"),
                            // subtitle: Text("Customer CMP: ${model.cmp}"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future get_JobStatus() async {
    var response = await http.get(Uri.parse(JobStatus));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      jobStatusList.clear();
      for (Map i in result) {
        jobStatusList.add(JobStatusModel.fromJson(i));
      }
      setState(() {});
    } else {}
  }

  Future get_TechnicianComparison() async {
    var response = await http.get(Uri.parse(TechnicianComparison));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      technicianComparisonList.clear();
      for (Map i in result) {
        technicianComparisonList.add(TechnicianComparisonModel.fromJson(i));
      }
      setState(() {});
    } else {}
  }

  Future post_DailyComparison() async {
    var response = await http.post(Uri.parse(DailyComparison), body: {
      'FDayNum': '4',
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      dailyComparisonList.clear();
      for (Map i in result) {
        dailyComparisonList.add(DailyComparisonModel.fromJson(i));
      }
      setState(() {});
    }
  }

  Future<void> _showPhoneDialog(String phoneNumber) async {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          content: Text('Would you like to call or message on WhatsApp?'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.phone,
                  size: _height * 0.04, color: Color(0xff06D001)),
              onPressed: () {
                _makePhoneCall(phoneNumber);
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                _openWhatsApp(phoneNumber);
                Navigator.of(context).pop();
              },
              child: Container(
                height: _height * 0.04,
                child: Image.asset('assets/whatsapp.png'),
              ),
            )
          ],
        );
      },
    );
  }

  ///-----------------------> Function to Navigate to phone dail <-----------------///
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  ///-------------------> Function to Navigate to whatsapp <------------------///
  Future<void> _openWhatsApp(String phoneNumber) async {
    final launchUri = Uri(
      scheme: 'https',
      path: 'wa.me/$phoneNumber',
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch WhatsApp for $phoneNumber';
    }
  }
  getLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    name = sp.getString('userName');
    setState(() {});
  }
}
