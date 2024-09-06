import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../APIs/apis.dart';
import '../../../../Models/GetComplain/GetComplainModel.dart';
import '../../../../Models/GetJobInfo/JobInfoModel.dart';
import '../../../../Models/Pending/TechnicianPendingJobsModel.dart';
import '../../../../Utilities/Colors/colors.dart';
import 'VisitForm/pendingVisitFormUi.dart';

class PendingVisitScreen extends StatefulWidget {
  TechnicianPendingJobsModel technicalPendingModel;

  PendingVisitScreen({super.key, required this.technicalPendingModel});

  @override
  State<PendingVisitScreen> createState() => _PendingVisitScreenState();
}

class _PendingVisitScreenState extends State<PendingVisitScreen> {
  List<JobInfoModel> JobInfoList = [];
  bool isLoading = true;
  bool isDataEmpty = false;

  @override
  void initState() {
    super.initState();
    Post_GetJobInfo();
  }

  @override
  Widget build(BuildContext context) {
    bool areAllVisitsCompleted = JobInfoList.isNotEmpty &&
        JobInfoList[0].tdat001 != null &&
        JobInfoList[0].tdat002 != null &&
        JobInfoList[0].tdat003 != null &&
        JobInfoList[0].tdat004 != null &&
        JobInfoList[0].trem001 != null &&
        JobInfoList[0].trem002 != null &&
        JobInfoList[0].trem003 != null &&
        JobInfoList[0].trem004 != null;
    return RefreshIndicator(
      onRefresh: Post_GetJobInfo,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Visit',
            style: TextStyle(color: ColorsUtils.whiteColor),
          ),
          backgroundColor: ColorsUtils.baigeColor,
          iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: isDataEmpty || areAllVisitsCompleted
              ? null
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PendingVisitFormUI(
                                getJobInfo: JobInfoList[0],
                              ))).then((value) => Post_GetJobInfo());
                },
          child: Icon(Icons.add),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : isDataEmpty
                ? Center(child: Text("No data available"))
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: ListView.builder(
                      itemCount: JobInfoList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (JobInfoList[index].tdat001 != null &&
                                  JobInfoList[index].trem001 != null)
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat('dd-MM-yyyy').format(DateTime.parse( JobInfoList[index]
                                                .tdat001
                                                .toString()
                                                .trim(),)),

                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            JobInfoList[index]
                                                .trem001
                                                .toString()
                                                .trim(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (JobInfoList[index].tdat002 != null &&
                                  JobInfoList[index].trem002 != null)
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat('dd-MM-yyyy').format(DateTime.parse( JobInfoList[index]
                                                .tdat002
                                                .toString()
                                                .trim(),)),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            JobInfoList[index]
                                                .trem002
                                                .toString()
                                                .trim(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (JobInfoList[index].tdat003 != null &&
                                  JobInfoList[index].trem003 != null)
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat('dd-MM-yyyy').format(DateTime.parse( JobInfoList[index]
                                                .tdat003
                                                .toString()
                                                .trim(),)),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            JobInfoList[index]
                                                .trem003
                                                .toString()
                                                .trim(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (JobInfoList[index].tdat004 != null &&
                                  JobInfoList[index].trem004 != null)
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat('dd-MM-yyyy').format(DateTime.parse( JobInfoList[index]
                                                .tdat004
                                                .toString()
                                                .trim(),)),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            JobInfoList[index]
                                                .trem004
                                                .toString()
                                                .trim(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  Future Post_GetJobInfo() async {
    var response = await http.post(Uri.parse(GetJobInfo), body: {
      'FJobNum': widget.technicalPendingModel.tjobnum.toString(),
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      JobInfoList.clear();
      if (result.isEmpty) {
        setState(() {
          isLoading = false;
          isDataEmpty = true;
        });
      } else {
        for (Map i in result) {
          JobInfoList.add(JobInfoModel.fromJson(i));
        }
        setState(() {
          isLoading = false;
          isDataEmpty = JobInfoList.isEmpty;
        });
      }
    } else {
      setState(() {
        isLoading = false;
        isDataEmpty = true;
      });
    }
  }
}
