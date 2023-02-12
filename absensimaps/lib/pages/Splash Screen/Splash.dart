import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(218, 220, 255, 1),
        body: Column(
          children: [
            Image.asset(
              fit: BoxFit.cover,
              "assets/images/splash.png",
              // width: Get.width * 2.1,
              height: Get.width * 2.22,
            ),
            // Image.asset(
            //   "assets/images/footer.png",
            //   width: Get.width * 0.5,
            //   height: Get.width * 0.5,
            // ),
          ],
        ),
      ),
    );
  }
}
