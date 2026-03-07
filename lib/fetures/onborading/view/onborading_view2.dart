import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/shared/Customtext.dart';
import 'package:gap/gap.dart';

class OnboradingView2 extends StatelessWidget {
  const OnboradingView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Gap(90.h),

              SizedBox(
                width: 190.w,
                child: AspectRatio(
                  aspectRatio: 170 / 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      "assets/images/b2.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              Gap(54.h),

              Customtext(
                text: "Touches That Transform",
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                centerLastWord: false,
              ),

              Gap(16.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: Customtext(
                  text:
                      "Small details, big difference, elevate your \ninteriors effortlessly.",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xff646464),
                  centerLastWord: true,
                ),
              ),

              const Spacer(),
              Gap(55.h),
            ],
          ),
        ),
      ),
    );
  }
}
