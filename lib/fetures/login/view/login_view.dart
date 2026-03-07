import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furneture_app/fetures/create_account/widgets/customtextfromfield.dart';
import 'package:furneture_app/fetures/create_account/widgets/socialbottom.dart';
import 'package:furneture_app/fetures/login/cubit/login_cubit.dart';
import 'package:furneture_app/fetures/login/cubit/login_state.dart';
import 'package:furneture_app/root.dart';
import 'package:furneture_app/shared/Customtext.dart';
import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    email.text = "shawki387@gmail.com";
    password.text = "123456789";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<AuthCubit>(),
                  child: const Root(),
                ),
              ),
            );
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(16.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                backgroundColor: Colors.red.shade600,
                content: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.white),
                    Gap(10.w),
                    Expanded(
                      child: Text(
                        state.message,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xffF4F4F4),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              leading: const BackButton(),
              title: Text(
                "Login",
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(20.h),

                      Text(
                        "Email or Phone number *",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Gap(8.h),

                      Customtextfromfield(
                        hint: "Enter your email or phone number",
                        icon: Icons.mail_outline,
                        controller: email,
                        obscure: false,
                      ),

                      Gap(20.h),

                      Text("Password *", style: TextStyle(fontSize: 14.sp)),
                      Gap(8.h),

                      Customtextfromfield(
                        controller: password,
                        hint: "Enter your password",
                        icon: Icons.lock_outline,
                        obscure: obscurePassword,
                        suffix: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),

                      Gap(12.h),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Customtext(
                          text: "Forgot Password?",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),

                      Gap(20.h),

                      Text.rich(
                        TextSpan(
                          text: "By continuing you agree to our ",
                          style: TextStyle(fontSize: 12.sp),
                          children: const [
                            TextSpan(
                              text: "Terms of Service",
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),

                      Gap(30.h),

                      /// Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 55.h,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                email: email.text,
                                password: password.text,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffD9772B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          child: state is AuthLoading
                              ? SizedBox(
                                  width: 22.w,
                                  height: 22.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Customtext(
                                  text: 'Login',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                        ),
                      ),

                      Gap(20.h),

                      Center(
                        child: Customtext(
                          text: 'Or using other methods',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),

                      Gap(20.h),

                      Socialbottom(
                        text: "Sign In with Google",
                        icon: FontAwesomeIcons.google,
                        color: Colors.red,
                      ),

                      Gap(12.h),

                      Socialbottom(
                        text: "Sign In with Facebook",
                        icon: FontAwesomeIcons.facebookF,
                        color: const Color(0xff1877F2),
                      ),

                      Gap(30.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
