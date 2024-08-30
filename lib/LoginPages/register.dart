import 'package:al_makkah/LoginPages/loginscreen.dart';
import 'package:al_makkah/Utilities/Colors/colors.dart';
import 'package:al_makkah/Utilities/Loader/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
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
    return SingleChildScrollView(
      child: Material(
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
                child: Image.asset("assets/al-makkah.png",),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: _width * 0.85,
                height: _height * 0.6,
                decoration: const BoxDecoration(
                  color: Color(0xffF6EACB),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Please Register Your Account",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: _width * 0.67,
                      height: _height * 0.07,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "Name",
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.grey,
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
                                  : FontAwesomeIcons.eye,color:Colors.grey,),
                            ),
                            labelText: "Password",
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
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.mobile,
                              color: Colors.grey,
                            ),
                            labelText: "Mobile No",
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () {
                        CircularIndicator.showLoader(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: _width * 0.67,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(7)),
                          color: ColorsUtils.baigeColor
                            ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginUI()));
                    }, child:  Text('Already have an Account?',style: TextStyle(color: ColorsUtils.baigeColor),))
                    // const SizedBox(height: 15,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     IconButton(
                    //         onPressed: () {},
                    //         icon: const Icon(
                    //             FontAwesomeIcons.facebook, color: Colors.blue)
                    //     ),
                    //     IconButton(
                    //         onPressed: () {},
                    //         icon: const Icon(
                    //           FontAwesomeIcons.google, color: Colors.redAccent,)
                    //     ),
                    //     IconButton(
                    //         onPressed: () {},
                    //         icon: const Icon(
                    //           FontAwesomeIcons.twitter, color: Colors
                    //             .orangeAccent,)
                    //     ),
                    //     IconButton(
                    //         onPressed: () {},
                    //         icon: const Icon(
                    //           FontAwesomeIcons.linkedinIn, color: Colors.green,)
                    //     )
                    //   ],
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
