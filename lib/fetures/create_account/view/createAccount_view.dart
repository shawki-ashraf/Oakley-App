// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/fetures/create_account/view/createAccount_view1.dart';
import 'package:furneture_app/fetures/login/view/login_view.dart';
import 'package:furneture_app/shared/Customtext.dart';
import 'package:furneture_app/shared/custom_bottom.dart';
import 'package:gap/gap.dart';

class CreateaccountView extends StatefulWidget {
  const CreateaccountView({super.key});

  @override
  State<CreateaccountView> createState() => _CreateaccountViewState();
}

class _CreateaccountViewState extends State<CreateaccountView> {
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage("assets/images/c1.webp"), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Image
          SizedBox.expand(
            child: Image.asset("assets/images/c1.webp", fit: BoxFit.cover),
          ),

          /// Dark Overlay
          // ignore: deprecated_member_use
          Container(color: Colors.black.withOpacity(0.15)),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  Gap(60.h),

                  Customtext(
                    text: "Discover",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),

                  Gap(12.h),

                  Customtext(
                    text: "Pick the most comfy furniture for you.",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),

                  const Spacer(),

                  /// Create Account Button
                  CustomBottom(
                    text: "Create Account",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CreateaccountView1(),
                        ),
                      );
                    },
                  ),

                  Gap(12.h),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginView()),
                      );
                    },
                    child: Customtext(
                      text: "Already Have an Account?",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),

                  Gap(46.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
