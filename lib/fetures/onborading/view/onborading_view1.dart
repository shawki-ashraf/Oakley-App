import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/shared/Customtext.dart';
import 'package:gap/gap.dart';

class OnboardingView1 extends StatelessWidget {
  const OnboardingView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Gap(120.h),

              Container(
                width: 190.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset("assets/images/b1.png", fit: BoxFit.cover),
                ),
              ),

              Gap(54.h),

              Customtext(
                text: "Style Starts with the Small Things",
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                centerLastWord: true,
              ),

              Gap(16.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: Customtext(
                  text:
                      "From vases to candle holders, find the\n accents that complete your space.",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xff646464),
                  centerLastWord: true,
                ),
              ),

              Gap(76.h),
            ],
          ),
        ),
      ),
    );
  }
}
