import 'dart:convert';

import 'package:al_makkah/AdminPanel/Dashboard%20Screens/UnassignedJobs/unassignedCustomerDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../APIs/apis.dart';
import '../../../InstallerPanel/DashboardScreens/Installed/InstalledCustomerProfiles/installedCustomerProfile.dart';
import '../../../Models/UnassignedJobs/UnAssignedJobsModel.dart';
import '../../../Utilities/Colors/colors.dart';

class UnassignedComplainsUI extends StatefulWidget {
  const UnassignedComplainsUI({super.key});

  @override
  State<UnassignedComplainsUI> createState() => _UnassignedComplainsUIState();
}

class _UnassignedComplainsUIState extends State<UnassignedComplainsUI> {
  List<UnAssignedJobsModel> unAssignedJobList = [];
  List<UnAssignedJobsModel> searchUnssignedList = [];
  bool loading = true;


  @override
  void initState() {
    super.initState();
    Post_InstalledTechnicianJob();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UnAssigned Applications',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.baigeColor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: RefreshIndicator(
          onRefresh: Post_InstalledTechnicianJob,
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
                    : searchUnssignedList
                    .isEmpty
                    ? Center(
                    child: Text(
                      "No Application is Installed",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ))
                    : ListView.builder(
                    itemCount: searchUnssignedList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => _buildBottomSheet(
                                context, searchUnssignedList[index]),
                          );
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
                                      searchUnssignedList[index]
                                          .tjobnum
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xffF58634),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Text(
                                      '  -  ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      DateFormat('dd-MM-yyyy').format(DateTime.parse(searchUnssignedList[index].tjobdat.toString())),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Text(
                                  searchUnssignedList[index]
                                      .tcstnam
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  searchUnssignedList[index]
                                      .tmobnum
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
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

  Widget _buildBottomSheet(BuildContext context, UnAssignedJobsModel model) {
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
                        Text(
                          model.tcstnam.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            _showPhoneDialog(model.tmobnum.toString());
                          },
                          child: Text(
                            model.tmobnum.toString(),
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: ColorsUtils.appcolor,
                              decorationThickness: 2,
                              fontSize: 16,
                              color: ColorsUtils.appcolor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Customer CMP: ${model.tjobnum}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UnassignedCustomerDetails(
                                          unAssignedJobsModel: model,)));
                          },
                          child: const ListTile(
                            leading: Icon(Icons.info),
                            title: Text("Information"),
                            // subtitle: Text("Customer CMP: ${model.cmp}"),
                          ),
                        ),
                        // InkWell(
                        //   onTap: (){
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 InstalledVisitScreen(
                        //                     installedModel: model)));
                        //   },
                        //   child: const ListTile(
                        //     leading: Icon(Icons.location_on),
                        //     title: Text("Visit"),
                        //     // subtitle: Text("Visit Date: ${model.date}"),
                        //   ),
                        // ),
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

  Future Post_InstalledTechnicianJob() async {
    var response = await http.get(Uri.parse(GetUnassignedComplains));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      unAssignedJobList.clear();
      for (Map i in result) {
        unAssignedJobList.add(UnAssignedJobsModel.fromJson(i));
      }
      setState(() {
        searchUnssignedList = List.from(unAssignedJobList);
      });
    } else {
      setState(() {
        loading = false; // Update loading state in case of an error
      });
    }
  }


  void search(String query) {
    setState(() {
      searchUnssignedList = unAssignedJobList.where((category) {
        final customerNameMatches =
            category.tcstnam?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        final mobileNumberMatches =
            category.tmobnum?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        final complainNumberMatches =
            category.tjobnum?.toLowerCase().contains(query.toLowerCase()) ?? false;
        return customerNameMatches ||
            mobileNumberMatches ||
            complainNumberMatches;
      }).toList();
    });
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
}
