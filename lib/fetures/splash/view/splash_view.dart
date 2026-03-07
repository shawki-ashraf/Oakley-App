import 'package:flutter/material.dart';
import 'package:furneture_app/fetures/onborading/view/onborading_view.dart';
import 'package:furneture_app/shared/Customtext.dart';
import 'package:furneture_app/constant/appcolors_const.dart';
import 'package:gap/gap.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppcolorsConst.primery,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // مهم للتوسيط
          children: [
            Customtext(
              text: "Oakley",
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            Gap(9),
            Customtext(
              text: "Shop smart. Stay cozy",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
