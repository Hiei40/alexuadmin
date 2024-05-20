import 'package:alexuadmin/persintation/OnBoarding/OnBoarding.dart';
import 'package:alexuadmin/persintation/auth/login_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 6), () {
      SharedPreferences.getInstance().then((prefs) {
        if (prefs.getBool('onboarding_shown') == true) {
          // Onboarding has been shown before, navigate to LoginCheck
          Navigator.of(_context).pushReplacement(MaterialPageRoute(
            builder: (_) => LoginCheck(),
          ));
        } else {
          // Onboarding has not been shown before, navigate to OnBoarding
          Navigator.of(_context).pushReplacement(MaterialPageRoute(
            builder: (_) => OnBoarding(),
          ));
          // Set the flag to true to indicate that onboarding has been shown
          prefs.setBool('onboarding_shown', true); // Change to true
        }
      });
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      body: Builder(
        builder: (context) {
          _context = context;
          return Container(
            width: double.infinity,
            color: const Color(0xff87CEEB),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("Image/gradp.png"),
              ],
            ),
          );
        },
      ),
    );
  }
}
