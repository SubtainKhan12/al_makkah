import 'dart:convert';
import 'package:al_makkah/NotificationService/getServerKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../APIs/apis.dart';
import '../../../LoginPages/loginscreen.dart';
import '../../../Models/TechnicianStatus/TechnicianStatusModel.dart';
import '../../../SplashScreen/splashScreen.dart';
import '../../../Utilities/Colors/colors.dart';
import '../DoneInstallations/done.dart';
import '../Pending/pending.dart';

class DashboardUI extends StatefulWidget {
  const DashboardUI({super.key});

  @override
  State<DashboardUI> createState() => _DashboardUIState();
}

class _DashboardUIState extends State<DashboardUI> {
  List<TechnicianStatusModel> technicianStatusList = [];
  String? technicianCode, name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery
        .of(context)
        .size
        .height;
    var _width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello ${name.toString().trim()}',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.baigeColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: RefreshIndicator(
          onRefresh: post_TechnicianStatus,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: technicianStatusList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PendingUI())).then((value)=>post_TechnicianStatus());
                            },
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(5),
                              // surfaceTintColor: Colors.blue,
                              shadowColor: Colors.white,
                              child: Container(
                                height: _height * 0.15,
                                width: _width * 0.3,
                                child: Column(
                                  children: [
                                    Container(
                                      height: _height * 0.05,
                                      decoration: BoxDecoration(
                                          color: ColorsUtils.baigeColor,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5)),
                                          border: Border.all(
                                              color: ColorsUtils.greyColor)),
                                      child: Center(
                                        child: Text(
                                          'Pending',
                                          style: TextStyle(
                                              fontSize: _height * 0.02,
                                              color: ColorsUtils.whiteColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: _height * 0.1,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              bottomRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5)),
                                          border: Border.all(
                                              color: ColorsUtils.greyColor)),
                                      child: Center(
                                          child: Text(
                                            technicianStatusList[index]
                                                .pending
                                                .toString()
                                                .trim() ==
                                                'null'
                                                ? '0'
                                                : technicianStatusList[index]
                                                .pending
                                                .toString()
                                                .trim(),
                                            style: TextStyle(
                                                fontSize: _height * 0.07,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade400),
                                          )),
                                    )
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
                                      builder: (context) => DoneUI())).then((value)=>post_TechnicianStatus());
                            },
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(5),
                              // surfaceTintColor: Colors.blue,
                              shadowColor: Colors.white,
                              child: Container(
                                height: _height * 0.15,
                                width: _width * 0.3,
                                child: Column(
                                  children: [
                                    Container(
                                      height: _height * 0.05,
                                      decoration: BoxDecoration(
                                          color: ColorsUtils.baigeColor,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5)),
                                          border: Border.all(
                                              color: ColorsUtils.greyColor)),
                                      child: Center(
                                        child: Text(
                                          'Done',
                                          style: TextStyle(
                                              fontSize: _height * 0.02,

                                              color: ColorsUtils.whiteColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: _height * 0.1,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              bottomRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5)),
                                          border: Border.all(
                                              color: ColorsUtils.greyColor)),
                                      child: Center(
                                          child: Text(
                                            technicianStatusList[index]
                                                .done
                                                .toString()
                                                .trim() ==
                                                'null'
                                                ? '0'
                                                : technicianStatusList[index]
                                                .done
                                                .toString()
                                                .trim(),
                                            style: TextStyle(
                                                fontSize: _height * 0.07,

                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade400),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(5),
                            // surfaceTintColor: Colors.blue,
                            shadowColor: Colors.white,
                            child: Container(
                              height: _height * 0.15,
                              width: _width * 0.3,
                              child: Column(
                                children: [
                                  Container(
                                    height: _height * 0.05,
                                    decoration: BoxDecoration(
                                        color: ColorsUtils.baigeColor,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)),
                                        border: Border.all(
                                            color: ColorsUtils.greyColor)),
                                    child: Center(
                                      child: Text(
                                        'Closed',
                                        style: TextStyle(
                                            fontSize: _height * 0.02,

                                            color: ColorsUtils.whiteColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: _height * 0.1,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5)),
                                        border: Border.all(
                                            color: ColorsUtils.greyColor)),
                                    child: Center(
                                        child: Text(
                                          technicianStatusList[index]
                                              .closed
                                              .toString()
                                              .trim() ==
                                              'null'
                                              ? '0'
                                              : technicianStatusList[index]
                                              .closed
                                              .toString()
                                              .trim(),
                                          style: TextStyle(
                                              fontSize: _height * 0.07,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade400),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              // ElevatedButton(onPressed: () async{
              //   GetServerKey getServerKey = GetServerKey();
              //   String accessToken = await getServerKey.GetServerKeyToken();
              //   print('---------------------->$accessToken');
              // }, child: Text("GetServerKey"))
            ],
          ),
        ),
      ),
    );
  }

  Future post_TechnicianStatus() async {
    var response = await http.post(Uri.parse(TechnicianStatus), body: {
      'FTchCod': technicianCode.toString(),
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      technicianStatusList.clear();
      for (Map i in result) {
        technicianStatusList.add(TechnicianStatusModel.fromJson(i));
      }
      setState(() {});
    }
  }

  getLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    technicianCode = sp.getString('technicianCode');
    name = sp.getString('userName');
    setState(() {});
    post_TechnicianStatus();
  }
  Future<void> logout() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove(SplashScreenState.KEYLOGIN); // Remove login state
    sharedPref.remove('userType'); // Remove user type

    // Navigate to the Login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginUI()),
          (Route<dynamic> route) => false,
    );
  }

}
