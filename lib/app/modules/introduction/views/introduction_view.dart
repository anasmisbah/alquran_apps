import 'package:alquran_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Al-quran Apps",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF672CBC),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Learn Quran and Recite once everyday",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF8789A3),
                ),
              ),
            ),
            SizedBox(
              height: 49,
            ),
            Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      padding: EdgeInsets.only(bottom: 80),
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF3B1E77),
                      ),
                      child: Image.asset(
                        'assets/images/introduction.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Positioned.fill(
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.HOME);
                      },
                      child: Text("Get Started"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF9B091),
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
