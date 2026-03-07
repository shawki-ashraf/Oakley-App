// ignore: file_names
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

class CreateaccountView1 extends StatefulWidget {
  const CreateaccountView1({super.key});

  @override
  State<CreateaccountView1> createState() => _CreateaccountView1State();
}

class _CreateaccountView1State extends State<CreateaccountView1> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xffF4F4F4),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: const BackButton(),
          title: Text(
            "Create Account",
            style: TextStyle(color: Colors.black, fontSize: 16.sp),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  /// Username
                  Text("Username *", style: TextStyle(fontSize: 14.sp)),
                  SizedBox(height: 8.h),
                  Customtextfromfield(
                    hint: "Create your username",
                    icon: Icons.person_outline,
                    obscure: false,
                    controller: usernameController,
                  ),

                  SizedBox(height: 20.h),

                  /// Email
                  Text(
                    "Email or Phone number *",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 8.h),
                  Customtextfromfield(
                    hint: "Enter your email or phone number",
                    icon: Icons.mail_outline,
                    obscure: false,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 20.h),

                  /// Password
                  Text("Password *", style: TextStyle(fontSize: 14.sp)),
                  SizedBox(height: 8.h),
                  Customtextfromfield(
                    hint: "Create your Password",
                    controller: passwordController,
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

                  SizedBox(height: 12.h),

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

                  SizedBox(height: 30.h),

                  /// Create Account Button
                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
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
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      state.message,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return Center(
                            child: SizedBox(
                              width: 22.w,
                              height: 22.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(
                                  Colors.deepOrange,
                                ),
                              ),
                            ),
                          );
                        }

                        return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().register(
                                email: emailController.text,
                                password: passwordController.text,
                                name: usernameController.text,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffD9772B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          child: Customtext(
                            text: 'Create Account',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Center(
                    child: Customtext(
                      text: 'Or using other methods',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Socialbottom(
                    text: "Sign In with Google",
                    icon: FontAwesomeIcons.google,
                    color: Colors.red,
                  ),

                  SizedBox(height: 12.h),

                  Socialbottom(
                    text: "Sign In with Facebook",
                    icon: FontAwesomeIcons.facebookF,
                    color: const Color(0xff1877F2),
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
