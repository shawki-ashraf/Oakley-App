import 'package:flutter/material.dart';
import 'package:furneture_app/constant/appcolors_const.dart';
import 'package:furneture_app/fetures/create_account/view/createAccount_view.dart';
import 'package:furneture_app/fetures/onborading/view/onborading_view.3.dart';
import 'package:furneture_app/fetures/onborading/view/onborading_view1.dart';
import 'package:furneture_app/fetures/onborading/view/onborading_view2.dart';
import 'package:furneture_app/shared/custom_bottom.dart';
import 'package:gap/gap.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // المتغير اللي يتحكم في الصفحة الحالية
  int currentIndex = 0;

  // PageController للتحكم في PageView
  final PageController _controller = PageController();

  // الصفحات الثلاثة
  final List<Widget> pages = const [
    OnboardingView1(),
    OnboradingView2(),
    OnboradingView3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // الـ PageView اللي تعرض الصفحات
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index; // تحديث الصفحة الحالية
                });
              },
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
          ),

          const Gap(20),

          // الدوتس تحت الصفحات
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? AppcolorsConst.primery
                      : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          const Gap(20),

          CustomBottom(
            text: currentIndex == pages.length - 1 ? "Get Started" : "Next",
            onTap: () {
              if (currentIndex < pages.length - 1) {
                currentIndex++;

                _controller.animateToPage(
                  currentIndex,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );

                setState(() {});
              } else {
                // 👇 لما يكون آخر صفحة
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateaccountView()),
                );
              }
            },
          ),

          // زرار Next / Get Started
          const Gap(70),
        ],
      ),
    );
  }
}
