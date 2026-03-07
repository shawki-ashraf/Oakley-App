import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/shared/Customtext.dart';
import 'package:gap/gap.dart';

class OnboradingView3 extends StatelessWidget {
  const OnboradingView3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Gap(120.h),

              SizedBox(
                width: 190.w,
                height: 200.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    "assets/images/b3.png",
                    fit: BoxFit.contain, // 👈 طبيعي بدون قص
                  ),
                ),
              ),

              Gap(54.h),

              Customtext(
                text: "Make Every Surface Count",
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
                      "Dress up your shelves, coffee tables, and\n corners with our curated collection.",
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
