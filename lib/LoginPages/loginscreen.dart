import 'dart:convert';
import 'package:al_makkah/CustomerPanel/NewComplain/newComplain.dart';
import 'package:al_makkah/LoginPages/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../APIs/apis.dart';
import '../AdminPanel/Dashboard Screens/AdminDashboard/adminDashboard.dart';
import '../InstallerPanel/DashboardScreens/Dashboard/dashboard.dart';
import '../Models/LoginModel/LoginModel.dart';
import '../NotificationService/notificationService.dart';
import '../SharedPreferences/sharedPreferences.dart';
import '../SplashScreen/splashScreen.dart';
import '../Utilities/Colors/colors.dart';
import '../Utilities/Loader/loader.dart';
import '../Utilities/Snackbar/snackbar.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  LoginModel? loginModelList;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String? _token;
  static String KEYNAME = "userId";

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushNotificationServices().gettoken().then((token) {
      setState(() {
        _token = token;
        print(_token);
      });
    });
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
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          color: Color(0xffFFF6EA),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: _height * 0.05,
              ),
              Container(
                height: _height * 0.22,
                width: _width * 0.55,
                // color: Color(0xffAAB396),
                child: Image.asset(
                  "assets/al-makkah.png",
                ),
              ),
              SizedBox(
                height: _height * 0.01,
              ),
              Container(
                width: _width * 0.85,
                height: _height * 0.45,
                decoration: const BoxDecoration(
                  color: Color(0xffF6EACB),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: _height * 0.05,

                    ),
                    SizedBox(
                      width: _width * 0.67,
                      height: _height * 0.07,
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            suffix: Icon(
                              Icons.email_outlined,
                              color: Colors.red,
                            ),
                            labelText: "Email Address",
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.013,

                    ),
                    Container(
                      width: _width * 0.67,
                      height: _height * 0.07,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            suffix: IconButton(
                                onPressed: _toggleObscureText,
                                icon: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            labelText: "Password",
                            border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'New Job',
                                style: TextStyle(color: ColorsUtils.baigeColor,
                                    fontSize: _height * 0.017),
                              )),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const RegisterUI()));
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(color: ColorsUtils.baigeColor,
                                  fontSize: _height * 0.017),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forget Password",
                            style: TextStyle(color: ColorsUtils.baigeColor,
                                fontSize: _height * 0.017),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        post_login();
                        CircularIndicator.showLoader(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: _width * 0.67,
                        height: _height * 0.065,
                        decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                            color: ColorsUtils.baigeColor),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: _height * 0.025,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.015,

              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomersUI()));
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 10,
                            shadowColor: const Color(0xffF6EACB),
                            child: Container(
                              height: _height * 0.06,
                              width: _width * 0.4,
                              decoration: BoxDecoration(
                                color: const Color(0xffF6EACB),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: _width * 0.03,
                                  ),
                                  Image.asset(
                                    'assets/install.png',
                                    color: Colors.blueAccent,
                                    height: _height * 0.03,
                                  ),
                                  const VerticalDivider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  // SizedBox(width: 20,),
                                  Text(
                                    'AC Installation',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: _height * 0.014),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> ExpenseUI()));
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(5),
                            elevation: 10,
                            shadowColor: const Color(0xffF6EACB),
                            child: Container(
                              height: _height * 0.06,
                              width: _width * 0.4,
                              decoration: BoxDecoration(
                                color: const Color(0xffF6EACB),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: _width * 0.03,
                                  ),
                                  Image.asset(
                                    'assets/clean.png',
                                    color: Colors.blueAccent,
                                    height: _height * 0.03,
                                  ),
                                  const VerticalDivider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  // SizedBox(width: 20,),
                                  Text(
                                    'Ac Service',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: _height * 0.014),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _height * 0.012,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => NewComplainUI()));
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(5),
                            elevation: 10,
                            shadowColor: const Color(0xffF6EACB),
                            child: Container(
                              height: _height * 0.06,
                              width: _width * 0.4,
                              decoration: BoxDecoration(
                                color: const Color(0xffF6EACB),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: _width * 0.03,
                                  ),
                                  Image.asset(
                                    'assets/complaint.png',
                                    color: Colors.red,
                                    height: _height * 0.03,
                                  ),
                                  const VerticalDivider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  // SizedBox(width: 20,),
                                  Text(
                                    'New Complain',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: _height * 0.014),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 10,
                          shadowColor: const Color(0xffF6EACB),
                          child: Container(
                            height: _height * 0.06,
                            width: _width * 0.4,
                            decoration: BoxDecoration(
                              color: const Color(0xffF6EACB),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: _width * 0.03,
                                ),
                                Image.asset(
                                  'assets/customer-ratings.png',
                                  color: Colors.red,
                                  height: _height * 0.03,
                                ),
                                const VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                                // SizedBox(width: 20,),
                                Text(
                                  'Complain Status',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: _height * 0.014),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/CrystalSolutionslogo.png',
                    height: _height * 0.04,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Powered by ",
                                style: TextStyle(
                                    color: ColorsUtils.blackColor)),
                            TextSpan(
                                text: "Crystal ",
                                style: TextStyle(
                                    color: ColorsUtils.blueCrystal,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "Solutions",
                                style: TextStyle(
                                    color: ColorsUtils.orangeCrystal,
                                    fontWeight: FontWeight.bold)),
                          ])),
                      RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Contact us: ",
                                style: TextStyle(
                                    color: ColorsUtils.blackColor)),
                            TextSpan(
                                text: "+92 304 4770075",
                                style: TextStyle(
                                    color: ColorsUtils.blueCrystal,
                                    fontWeight: FontWeight.bold)),
                          ])),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ///---------------Login API Function------------------///////////

  Future<void> post_login() async {
    if (_token == null) {
      Snackbar.showSnackBar(
          context, 'Token not available. Try again.', ColorsUtils.redColor);
      return;
    }

    var response = await http.post(Uri.parse(login), body: {
      'userid': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
      'token': _token,
    });

    if (response.statusCode == 200) {
      // print('<----------->$_token');
      var result = jsonDecode(response.body);
      loginModelList = LoginModel.fromJson(result);

      if (loginModelList?.user?.tusrid == _emailController.text.trim() &&
          loginModelList?.user?.tusrpwd == _passwordController.text.trim()) {
        Shared_pref.saveuser(loginModelList!.user!);

        if (loginModelList?.user?.tusrtyp == 'Technician') {
          var sharedPref = await SharedPreferences.getInstance();
          sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
          sharedPref.setString('userType', 'Technician');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DashboardUI()),
                (Route<dynamic> route) => false,
          );
          Snackbar.showSnackBar(context, 'Login Successful', Colors.teal);
        } else if (loginModelList?.user?.tusrtyp == 'Admin') {
          var sharedPref = await SharedPreferences.getInstance();
          sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
          sharedPref.setString('userType', 'Admin');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AdminDashboardUI()),
                (Route<dynamic> route) => false,
          );
          Snackbar.showSnackBar(context, 'Login Successful', Colors.teal);
        }
      } else {
        _emailController.clear();
        _passwordController.clear();
        Snackbar.showSnackBar(context, 'Wrong Credentials', Colors.red);
        Navigator.pop(context);
      }
    } else {
      Snackbar.showSnackBar(context, 'Login Failed', Colors.red);
      Navigator.pop(context);
    }
  }
}
