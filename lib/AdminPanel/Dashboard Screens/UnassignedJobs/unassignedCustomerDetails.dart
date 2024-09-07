import 'dart:convert';

import 'package:al_makkah/Models/UnassignedJobs/UnAssignedJobsModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';
import 'package:http/http.dart'as http;
import '../../../APIs/apis.dart';
import '../../../Models/GetJobInfo/JobInfoModel.dart';
import '../../../Utilities/Colors/colors.dart';

class UnassignedCustomerDetails extends StatefulWidget {
  UnAssignedJobsModel unAssignedJobsModel;
  UnassignedCustomerDetails({super.key,required this.unAssignedJobsModel});

  @override
  State<UnassignedCustomerDetails> createState() => _UnassignedCustomerDetailsState();
}

class _UnassignedCustomerDetailsState extends State<UnassignedCustomerDetails> {
  List<JobInfoModel> jobsInfoList = [];
  final translator = GoogleTranslator();
  bool _translatetext = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Post_GetJobInfo();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Detail',
            style: TextStyle(color: ColorsUtils.whiteColor),
          ),
          backgroundColor: ColorsUtils.baigeColor,
          iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _translatetext = false;
                      });
                    },
                    child: Text(
                      'Eng',
                      style: TextStyle(
                        fontSize: 16,
                        color: !_translatetext ? Colors.yellow : Colors.white,
                        fontWeight: !_translatetext
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text("|",
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorsUtils.whiteColor,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _translatetext = true;
                      });
                    },
                    child: Text(
                      'اردو',
                      style: TextStyle(
                        fontSize: 16,
                        color: _translatetext ? Colors.yellow : Colors.white,
                        fontWeight: _translatetext
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
      body: jobsInfoList.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
          itemCount: jobsInfoList.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Complain # : ',
                                  style: TextStyle(
                                      color: ColorsUtils.blackColor,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: jobsInfoList[index]
                                      .tjobnum
                                      .toString()
                                      .trim(),
                                  style: TextStyle(
                                      color: ColorsUtils.blackColor,
                                      fontWeight: FontWeight.bold)),
                            ])),
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Date : ',
                                  style: TextStyle(
                                      color: ColorsUtils.blackColor,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: DateFormat('dd-MM-yyyy')
                                      .format(DateTime.parse(
                                    jobsInfoList[index]
                                        .tjobdat
                                        .toString()
                                        .trim(),
                                  )),
                                  style:
                                  TextStyle(color: ColorsUtils.blackColor)),
                            ]))
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: InputDecorator(
                          decoration: InputDecoration(
                              labelText: 'Customer Information',
                              labelStyle: TextStyle(
                                  color: ColorsUtils.appcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                              )),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                        width: _width * 0.18,
                                        child: const Text(
                                          'Mobile#',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: _width * 0.02,
                                      child: const Text(
                                        ':',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // width: _width * 0.25,
                                        child: Text(jobsInfoList[index]
                                            .tmobnum
                                            .toString()
                                            .trim()))
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: _width * 0.18,
                                        child: const Text(
                                          'Customer',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: _width * 0.02,
                                      child: const Text(
                                        ':',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // width: _width * 0.25,
                                        child: Flexible(
                                          child: _translatetext == false
                                              ? Text(jobsInfoList[index]
                                              .tcstnam
                                              .toString()
                                              .trim())
                                              : FutureBuilder<String>(
                                            future: translateTextToUrdu(
                                                jobsInfoList[index]
                                                    .tcstnam
                                                    .toString()
                                                    .trim()),
                                            builder: (context, snapshot) {
                                              if (snapshot
                                                  .connectionState ==
                                                  ConnectionState
                                                      .waiting) {
                                                return Text(
                                                    'isLoading....'); // Show a spinner while translating
                                              } else if (snapshot
                                                  .hasError) {
                                                return Text(
                                                  jobsInfoList[index]
                                                      .tcstnam
                                                      .toString()
                                                      .trim(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                );
                                              } else {
                                                return Text(
                                                  snapshot.data ??
                                                      jobsInfoList[index]
                                                          .tcstnam
                                                          .toString()
                                                          .trim(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                );
                                              }
                                            },
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: _width * 0.18,
                                        child: const Text(
                                          'Address',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: _width * 0.02,
                                      child: const Text(
                                        ':',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // width: _width * 0.25,
                                        child: Flexible(
                                          child: _translatetext == false
                                              ? Text(jobsInfoList[index]
                                              .tadd001
                                              .toString()
                                              .trim())
                                              : FutureBuilder<String>(
                                            future: translateTextToUrdu(
                                                jobsInfoList[index]
                                                    .tadd001
                                                    .toString()
                                                    .trim()),
                                            builder: (context, snapshot) {
                                              if (snapshot
                                                  .connectionState ==
                                                  ConnectionState
                                                      .waiting) {
                                                return Text(
                                                    'isLoading....'); // Show a spinner while translating
                                              } else if (snapshot
                                                  .hasError) {
                                                return Text(
                                                  jobsInfoList[index]
                                                      .tadd001
                                                      .toString()
                                                      .trim(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                );
                                              } else {
                                                return Text(
                                                  snapshot.data ??
                                                      jobsInfoList[index]
                                                          .tadd001
                                                          .toString()
                                                          .trim(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: _width * 0.18,
                                        child: const Text(
                                          '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: _width * 0.02,
                                      child: const Text(
                                        ':',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // width: _width * 0.25,
                                        child: Flexible(
                                          child: _translatetext == false
                                              ? Text(jobsInfoList[index]
                                              .tadd002
                                              .toString()
                                              .trim())
                                              : FutureBuilder<String>(
                                            future: translateTextToUrdu(
                                                jobsInfoList[index]
                                                    .tadd002
                                                    .toString()
                                                    .trim()),
                                            builder: (context, snapshot) {
                                              if (snapshot
                                                  .connectionState ==
                                                  ConnectionState
                                                      .waiting) {
                                                return Text(
                                                    'isLoading....'); // Show a spinner while translating
                                              } else if (snapshot
                                                  .hasError) {
                                                return Text(
                                                  jobsInfoList[index]
                                                      .tadd002
                                                      .toString()
                                                      .trim(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                );
                                              } else {
                                                return Text(
                                                  snapshot.data ??
                                                      jobsInfoList[index]
                                                          .tadd002
                                                          .toString()
                                                          .trim(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: _width * 0.18,
                                        child: const Text(
                                          'City',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: _width * 0.02,
                                      child: const Text(
                                        ':',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // width: _width * 0.25,
                                        child: Flexible(
                                          child: Text(jobsInfoList[index]
                                              .city
                                              .toString()
                                              .trim()),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: InputDecorator(
                          decoration: InputDecoration(
                              labelText: 'Item Information',
                              labelStyle: TextStyle(
                                  color: ColorsUtils.appcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                              )),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: _width * 0.18,
                                        child: const Text(
                                          'Company',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: _width * 0.02,
                                      child: const Text(
                                        ':',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // width: _width * 0.25,
                                        child: Flexible(
                                          child: Text(jobsInfoList[index]
                                              .company
                                              .toString()
                                              .trim()),
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: _width * 0.18,
                                        child: const Text(
                                          'Category',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: _width * 0.02,
                                      child: const Text(
                                        ':',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // width: _width * 0.25,
                                        child: Flexible(
                                          child: Text(jobsInfoList[index]
                                              .category
                                              .toString()
                                              .trim()),
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: _width * 0.18,
                                        child: const Text(
                                          'Item',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: _width * 0.02,
                                      child: const Text(
                                        ':',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // width: _width * 0.25,
                                        child: Flexible(
                                          child: Text(jobsInfoList[index]
                                              .titmdsc
                                              .toString()
                                              .trim()),
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: _width * 0.18,
                                        child: const Text(
                                          'Serial No',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: _width * 0.02,
                                      child: const Text(
                                        ':',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // width: _width * 0.25,
                                        child: Flexible(
                                          child: Text(jobsInfoList[index]
                                              .titmser
                                              .toString()
                                              .trim()),
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      // height: _height * 0.14,
                      child: InputDecorator(
                          decoration: InputDecoration(
                              labelText: 'Engineer Information',
                              labelStyle: TextStyle(
                                  color: ColorsUtils.appcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                              )),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: _width * 0.18,
                                        child: const Text(
                                          'Engineer',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: _width * 0.02,
                                      child: const Text(
                                        ':',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // width: _width * 0.25,
                                        child: Flexible(
                                          child: Text(jobsInfoList[index]
                                              .technician
                                              .toString()
                                              .trim()),
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: _width * 0.18,
                                        child: const Text(
                                          'Mobile No',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: _width * 0.02,
                                      child: const Text(
                                        ':',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // width: _width * 0.25,
                                        child: Flexible(
                                            child: Text(jobsInfoList[index]
                                                .mobile
                                                .toString()
                                                .trim()))),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: _width * 0.18,
                                        child: const Text(
                                          'Assign On',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: _width * 0.02,
                                      child: const Text(
                                        ':',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // width: _width * 0.25,
                                        child: Flexible(
                                          child: Text(jobsInfoList[index]
                                              .tjobdat
                                              .toString()
                                              .trim()),
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Engineer Visit',
                          labelStyle: TextStyle(
                            color: ColorsUtils.appcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Column(
                          children: [
                            if (jobsInfoList[index]
                                .tdat001
                                .toString()
                                .trim() !=
                                'null' ||
                                jobsInfoList[index]
                                    .trem001
                                    .toString()
                                    .trim() !=
                                    'null')
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: _width * 0.22,
                                    child: Text(
                                      jobsInfoList[index]
                                          .tdat001
                                          .toString()
                                          .trim() ==
                                          'null'
                                          ? ''
                                          : DateFormat('dd-MM-yyyy')
                                          .format(DateTime.parse(
                                        jobsInfoList[index]
                                            .tdat001
                                            .toString()
                                            .trim(),
                                      )),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: _width * 0.02,
                                    child: const Text(
                                      ':',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      jobsInfoList[index]
                                          .trem001
                                          .toString()
                                          .trim() ==
                                          'null'
                                          ? ''
                                          : jobsInfoList[index]
                                          .trem001
                                          .toString()
                                          .trim(),
                                    ),
                                  ),
                                ],
                              ),
                            if (jobsInfoList[index]
                                .tdat002
                                .toString()
                                .trim() !=
                                'null' ||
                                jobsInfoList[index]
                                    .trem002
                                    .toString()
                                    .trim() !=
                                    'null')
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: _width * 0.22,
                                    child: Text(
                                      jobsInfoList[index]
                                          .tdat002
                                          .toString()
                                          .trim() ==
                                          'null'
                                          ? ''
                                          : DateFormat('dd-MM-yyyy')
                                          .format(DateTime.parse(
                                        jobsInfoList[index]
                                            .tdat002
                                            .toString()
                                            .trim(),
                                      )),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: _width * 0.02,
                                    child: const Text(
                                      ':',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      jobsInfoList[index]
                                          .trem002
                                          .toString()
                                          .trim() ==
                                          'null'
                                          ? ''
                                          : jobsInfoList[index]
                                          .trem002
                                          .toString()
                                          .trim(),
                                    ),
                                  ),
                                ],
                              ),
                            if (jobsInfoList[index]
                                .tdat003
                                .toString()
                                .trim() !=
                                'null' ||
                                jobsInfoList[index]
                                    .trem003
                                    .toString()
                                    .trim() !=
                                    'null')
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: _width * 0.22,
                                    child: Text(
                                      jobsInfoList[index]
                                          .tdat003
                                          .toString()
                                          .trim() ==
                                          'null'
                                          ? ''
                                          : DateFormat('dd-MM-yyyy')
                                          .format(DateTime.parse(
                                        jobsInfoList[index]
                                            .tdat003
                                            .toString()
                                            .trim(),
                                      )),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: _width * 0.02,
                                    child: const Text(
                                      ':',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      jobsInfoList[index]
                                          .trem003
                                          .toString()
                                          .trim() ==
                                          'null'
                                          ? ''
                                          : jobsInfoList[index]
                                          .trem003
                                          .toString()
                                          .trim(),
                                    ),
                                  ),
                                ],
                              ),
                            if (jobsInfoList[index]
                                .tdat004
                                .toString()
                                .trim() !=
                                'null' ||
                                jobsInfoList[index]
                                    .trem004
                                    .toString()
                                    .trim() !=
                                    'null')
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: _width * 0.22,
                                    child: Text(
                                      jobsInfoList[index]
                                          .tdat004
                                          .toString()
                                          .trim() ==
                                          'null'
                                          ? ''
                                          : DateFormat('dd-MM-yyyy')
                                          .format(DateTime.parse(
                                        jobsInfoList[index]
                                            .tdat004
                                            .toString()
                                            .trim(),
                                      )),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: _width * 0.02,
                                    child: const Text(
                                      ':',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      jobsInfoList[index]
                                          .trem004
                                          .toString()
                                          .trim() ==
                                          'null'
                                          ? ''
                                          : jobsInfoList[index]
                                          .trem004
                                          .toString()
                                          .trim(),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      // height: _height * 0.14,
                      // color: Color(0xff9DBDFF),
                      child: InputDecorator(
                          decoration: InputDecoration(
                              labelText: 'Status',
                              labelStyle: TextStyle(
                                  color: ColorsUtils.appcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                              )),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: _width * 0.22,
                                        child: const Text(
                                          'Status',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: _width * 0.02,
                                      child: const Text(
                                        ':',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      // width: _width * 0.25,
                                        child: Flexible(
                                          child: Text(
                                            jobsInfoList[index]
                                                .tjobsts
                                                .toString() ==
                                                'N'
                                                ? 'Pending'
                                                : jobsInfoList[index]
                                                .tjobsts
                                                .toString() ==
                                                'I'
                                                ? 'Installed'
                                                : jobsInfoList[index]
                                                .tjobsts
                                                .toString() ==
                                                'P'
                                                ? 'Pending'
                                                : jobsInfoList[index]
                                                .tjobsts
                                                .toString() ==
                                                ''
                                                ? 'UnAssigned'
                                                : jobsInfoList[index]
                                                .tjobsts
                                                .toString() ==
                                                'null'
                                                ? 'UnAssigned'
                                                : jobsInfoList[
                                            index]
                                                .tjobsts
                                                .toString(),
                                            style: TextStyle(
                                                color: ColorsUtils.redColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              if (jobsInfoList[index]
                                  .tclsrem
                                  .toString()
                                  .trim() !=
                                  'null'
                              )
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: _width * 0.22,
                                          child: const Text(
                                            'Remarks',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Container(
                                        width: _width * 0.02,
                                        child: const Text(
                                          ':',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        // width: _width * 0.25,
                                          child: Flexible(
                                            child: Text(jobsInfoList[index]
                                                .tclsrem
                                                .toString()
                                                .trim() ==
                                                'null'
                                                ? ''
                                                : jobsInfoList[index]
                                                .tclsrem
                                                .toString()
                                                .trim()),
                                          )),
                                    ],
                                  ),
                                ),
                              if (jobsInfoList[index]
                                  .tclsdat
                                  .toString()
                                  .trim() !=
                                  'null'
                              )
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: _width * 0.22,
                                          child: const Text(
                                            'Close Date',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Container(
                                        width: _width * 0.02,
                                        child: const Text(
                                          ':',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        // width: _width * 0.25,
                                          child: Flexible(
                                            child: Text(
                                              jobsInfoList[index]
                                                  .tclsdat
                                                  .toString()
                                                  .trim(),
                                              style: TextStyle(
                                                  color: ColorsUtils.redColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Future Post_GetJobInfo() async {
    var response = await http.post(Uri.parse(GetJobInfo), body: {
      'FJobNum': widget.unAssignedJobsModel.tjobnum.toString(),
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      jobsInfoList.clear();
      for (Map i in result) {
        jobsInfoList.add(JobInfoModel.fromJson(i));
      }
      setState(() {});
    } else {}
  }

  Future<String> translateTextToUrdu(String text) async {
    try {
      final translation = await translator.translate(text, to: 'ur');
      return translation.text ?? text;
    } catch (e) {
      print('Translation error: $e');
      return text; // Fallback to original text if translation fails
    }
  }
}
