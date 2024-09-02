import 'dart:convert';
import 'package:al_makkah/LoginPages/register.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../APIs/apis.dart';
import '../InstallerPanel/DashboardScreens/Dashboard/dashboard.dart';
import '../Models/LoginModel/LoginModel.dart';
import '../SharedPreferences/sharedPreferences.dart';
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

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [
            //   Color(0xffF6EACB),
            //   // Colors.black,
            //   Colors.white24,
            // ])
            color: Color(0xffFFF6EA),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Container(
                height: _height * 0.25,
                width: _width * 0.55,
                // color: Color(0xffAAB396),
                child: Image.asset(
                  "assets/al-makkah.png",
                ),
              ),
              const SizedBox(
                height: 10,
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
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: _width * 0.67,
                      height: _height * 0.07,
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.red,
                            ),
                            labelText: "Email Address",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
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
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye),
                            ),
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
                                style: TextStyle(color: ColorsUtils.baigeColor),
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
                              style: TextStyle(color: ColorsUtils.baigeColor),
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
                            style: TextStyle(color: ColorsUtils.baigeColor),
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
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7)),
                            color: ColorsUtils.baigeColor),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),

                  ],
                ),
              ),
              const SizedBox(
                height: 160,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/CrystalSolutionslogo.png',height: 30,),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Powered by ",
                            style: TextStyle(color: ColorsUtils.blackColor)),
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
                                style: TextStyle(color: ColorsUtils.blackColor)),
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
    // FocusScope.of(context).unfocus();
    var response = await http.post(Uri.parse(login), body: {
      'userid': _emailController.text,
      'password': _passwordController.text,
    });

    var result = jsonDecode(response.body);
    loginModelList = LoginModel.fromJson(result);

    if (result['error'] == 200) {
      Navigator.pop(context);
        Shared_pref.saveuser(loginModelList!.user!);
        // var sharedPref = await SharedPreferences.getInstance();
        // sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DashboardUI()));
        Snackbar.showSnackBar(context, 'Login Successful', Colors.teal);

    } else {
      _emailController.clear();
      _passwordController.clear();
      Snackbar.showSnackBar(context, 'Wrong Credentials', Colors.red);
      Navigator.pop(context);
    }
  }
}
