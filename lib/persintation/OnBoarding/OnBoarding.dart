import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Model/onBoarding.dart';
import '../../generated/l10n.dart';
import '../auth/login_check.dart';
import '../auth/login_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _boardController;

  @override
  void initState() {
    super.initState();
    _boardController = PageController();
  }

  void _completeOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboardingCompleted', true); // Set the flag indicating onboarding is completed
  }

  bool? _isOnboardingCompleted;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkOnboardingStatus();
  }

  void _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isOnboardingCompleted = prefs.getBool('onboardingCompleted');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isOnboardingCompleted == null) {
      // If onboarding status is not yet determined, show the onboarding screens
      List<OnBoardingModel> boarding = [
        OnBoardingModel(
          photo: 'Image/OnBoarding/Group 1.png',
          title: S.of(context).Connect_with_Peers,
          text: S.of(context).Foster,
        ),
        OnBoardingModel(
          photo: "Image/OnBoarding/Rectangle 2.png",
          title: S.of(context).Seamless_Registration,
          text: S.of(context).Effortlessly,
        ),
        OnBoardingModel(
          photo: "Image/OnBoarding/Rectangle 3.png",
          title: S.of(context).TrackyourProgress,
          text: S.of(context).Monitoryouracademic,
        ),
      ];

      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      return Scaffold(
        backgroundColor: Colors.lightBlue.shade100,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: height,
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                boarding[index].photo,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: height * 0.6, // Adjusted height
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: height * 0.05, right: width * 0.03),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        S.of(context).Skip,
                                        style: GoogleFonts.inter(
                                          color: Color(0xffFFFFFF),
                                          fontWeight: FontWeight.w700,
                                          fontSize: width * 0.05, // Adjusted font size
                                        ),
                                      ),
                                      onTap: () {
                                        _completeOnBoarding();
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) => LoginScreen()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            boarding[index].title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: width * 0.05, // Adjusted font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            boarding[index].text,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: width * 0.04, // Adjusted font size
                            ),
                          ),
                          Container(
                            child: SmoothPageIndicator(
                              controller: _boardController,
                              count: boarding.length,
                              effect: JumpingDotEffect(
                                activeDotColor: Color(0xff2191CE),
                                dotColor: Colors.white,
                                dotHeight: 16,
                                dotWidth: 16,
                                jumpScale: .7,
                                verticalOffset: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02, // Adjusted spacing
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              index == 0
                                  ? Container(
                                alignment: Alignment.center,
                                width: width * 0.24,
                                height: height * 0.06,
                                // Adjusted dimensions
                              )
                                  : InkWell(
                                onTap: () {
                                  _boardController.previousPage(
                                    duration: const Duration(milliseconds: 750),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width * 0.24,
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    color: Color(0xff87CEEB).withOpacity(0),
                                    border: Border.all(
                                      color: Color(0xff2191CE),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    "${S.of(context).Back}",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: width * 0.05,
                                      color: Color(0xff2191CE),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (_boardController.page == boarding.length - 1) {
                                    _completeOnBoarding();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) => LoginScreen()),
                                    );
                                  } else {
                                    _boardController.nextPage(
                                      duration: const Duration(milliseconds: 750),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                    );
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width * 0.24,
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    color: Color(0xff2191CE),
                                    border: Border.all(
                                      color: Color(0xff2191CE),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    index == 0 ? "${S.of(context).Start}" : "${S.of(context).Next}",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: width * 0.05,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                    itemCount: boarding.length,
                    controller: _boardController,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // If onboarding has been completed before or skipped, navigate to the login screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginCheck()),
        );
      });
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // Or any other loading indicator
        ),
      );
    }
  }
}
