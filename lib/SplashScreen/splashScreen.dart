import 'dart:async';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AdminPanel/Dashboard Screens/AdminDashboard/adminDashboard.dart';
import '../InstallerPanel/DashboardScreens/Dashboard/dashboard.dart';
import '../LoginPages/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = 'login';
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset(
            "assets/al-makkah.png",
            height: 400,
          ),
        ),
      ),
    );
  }

  Future whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(SplashScreenState.KEYLOGIN);
    var userType = sharedPref.getString('userType'); // Retrieve user type

    // Authenticate the user biometrically if they are logged in
    if (isLoggedIn != null && isLoggedIn) {
      bool authenticated = await _authenticateBiometric();

      if (authenticated) {
        Timer(Duration(seconds: 2), () {
          // Navigate based on user type after successful authentication
          if (userType == 'Technician') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardUI()), // Technician Panel
            );
          } else if (userType == 'Admin') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminDashboardUI()), // Admin Panel
            );
          }
        });
      } else {
        // If biometric authentication fails, you can show a message or navigate to the login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginUI()), // Fallback to login
        );
      }
    } else {
      // If the user is not logged in, navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginUI()),
      );
    }
  }

  Future<bool> _authenticateBiometric() async {
    try {
      // Check if device supports biometric authentication
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isBiometricSupported = await auth.isDeviceSupported();

      if (canCheckBiometrics && isBiometricSupported) {
        // Perform biometric authentication
        return await auth.authenticate(
          localizedReason: 'Please authenticate to continue',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      } else {
        // If biometric is not supported, return false
        return false;
      }
    } catch (e) {
      // Handle errors
      print("Biometric authentication error: $e");
      return false;
    }
  }
}
