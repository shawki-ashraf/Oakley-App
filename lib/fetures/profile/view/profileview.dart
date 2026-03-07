import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/fetures/create_account/view/createAccount_view.dart';
import 'package:furneture_app/fetures/login/view/login_view.dart';
import 'package:furneture_app/fetures/profile/cubit/profile_cubit.dart';
import 'package:furneture_app/fetures/profile/widgets/menutile.dart';
import 'package:furneture_app/fetures/profile/widgets/sectiontile.dart';
import 'package:furneture_app/fetures/profile/widgets/userinfo.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is Deleteloaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  "Account deleted successfully",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            );

            // Navigate to Login
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            );
          }

          if (state is DeleteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ProfileCubit>();

          return Scaffold(
            backgroundColor: Colors.white,
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                SizedBox(height: 50.h),

                /// USER INFO
                const UserInfo(),

                SizedBox(height: 25.h),

                /// PROFILE SECTION
                SectionTitle("Profile"),
                SizedBox(height: 10.h),

                MenuTile(icon: Icons.person_outline, title: "Edit Profile"),
                MenuTile(
                  icon: Icons.notifications_none,
                  title: "Notifications",
                ),
                MenuTile(icon: Icons.settings_outlined, title: "My Orders"),
                MenuTile(
                  icon: Icons.payment_outlined,
                  title: "Payment Methods",
                ),

                /// DELETE ACCOUNT
                MenuTile(
                  icon: Icons.delete_outline,
                  title: "Delete Account",
                  ontap: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        TextEditingController passwordController =
                            TextEditingController();
                        bool obscure = true;

                        return StatefulBuilder(
                          builder: (context, setState) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Confirm Account Deletion",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 15.h),
                                  TextField(
                                    controller: passwordController,
                                    obscureText: obscure,
                                    decoration: InputDecoration(
                                      hintText: "Enter your password",
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          obscure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            obscure = !obscure;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey[300],
                                          foregroundColor: Colors.black,
                                        ),
                                        onPressed: () =>
                                            Navigator.pop(dialogContext),
                                        child: const Text("Cancel"),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          cubit.deleteAccount(
                                            passwordController.text,
                                          );
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateaccountView(),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                SizedBox(height: 25.h),

                /// SETTINGS SECTION
                SectionTitle("Setting"),
                SizedBox(height: 10.h),

                MenuTile(icon: Icons.help_outline, title: "FAQ’s"),
                MenuTile(icon: Icons.headphones_outlined, title: "Help Center"),
                MenuTile(
                  icon: Icons.privacy_tip_outlined,
                  title: "Legal & Policies",
                ),

                SizedBox(height: 25.h),

                /// LOG OUT
                MenuTile(
                  icon: Icons.logout,
                  title: "Log out",
                  ontap: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Confirm Sign Out",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[300],
                                        foregroundColor: Colors.black,
                                      ),
                                      onPressed: () =>
                                          Navigator.pop(dialogContext),
                                      child: const Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        // تسجيل الخروج
                                        cubit.logout();

                                        // الانتقال لصفحة LoginView
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginView(),
                                          ),
                                          (route) => false,
                                        );
                                      },
                                      child: const Text("Sign Out"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                SizedBox(height: 30.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
