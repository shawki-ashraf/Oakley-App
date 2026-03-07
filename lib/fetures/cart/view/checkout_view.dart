import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/fetures/cart/cubit/add_tocart_cubit.dart';
import 'package:furneture_app/fetures/cart/widgets/check_data.dart';
import 'package:furneture_app/shared/Customtext.dart';
import 'package:furneture_app/shared/custom_bottom.dart';
import 'package:gap/gap.dart';

class CheckoutView extends StatefulWidget {
  final double tolalprice;

  const CheckoutView({super.key, required this.tolalprice});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'Cash';

  final Color selectedColor = const Color(0xff4E342E);
  final Color unSelectedColor = Colors.grey.shade200;

  static const double discount = 10.0;
  static const double deliveryFees = 16.73;
  static const double tax = 10.0;

  double get finalTotal => widget.tolalprice - discount + deliveryFees + tax;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTocartCubit, AddTocartState>(
      listener: (context, state) async {
        if (state is OrderLoading) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is OrderSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      "Order placed successfully 🎉",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: const Color(0xff2E7D32),
              elevation: 10,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.r),
              ),
              duration: const Duration(seconds: 2),
            ),
          );

          await Future.delayed(const Duration(seconds: 2));
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }

        if (state is OrderError) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.msg),
              backgroundColor: Colors.red.shade400,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Checkout", style: TextStyle(fontSize: 18.sp)),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Customtext(
                  text: "Order Summary",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

                Gap(20.h),

                CheckData(
                  title: 'Subtotal',
                  value: "${widget.tolalprice.toStringAsFixed(2)} EGP",
                ),
                Gap(15.h),
                const CheckData(title: 'Discount', value: "10.0 EGP"),
                Gap(15.h),
                const CheckData(title: 'Delivery fees', value: "16.73 EGP"),
                Gap(15.h),
                const CheckData(title: 'Tax', value: "10.0 EGP"),

                Gap(30.h),
                Divider(thickness: 2.w),
                Gap(20.h),

                Customtext(
                  text: "Payment Method",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

                Gap(20.h),

                /// CASH
                ListTile(
                  onTap: () => setState(() => selectedMethod = "Cash"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  tileColor: selectedMethod == "Cash"
                      ? selectedColor
                      : unSelectedColor,
                  leading: Image.asset("assets/logo/money.png", width: 45.w),
                  title: Customtext(
                    text: "Cash on Delivery",
                    color: selectedMethod == "Cash"
                        ? Colors.white
                        : Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  trailing: Radio<String>(
                    activeColor: Colors.white,
                    value: "Cash",
                    // ignore: deprecated_member_use
                    groupValue: selectedMethod,
                    // ignore: deprecated_member_use
                    onChanged: (v) => setState(() => selectedMethod = v!),
                  ),
                ),

                Gap(15.h),

                /// VISA
                ListTile(
                  onTap: () => setState(() => selectedMethod = "Visa"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  tileColor: selectedMethod == "Visa"
                      ? selectedColor
                      : unSelectedColor,
                  leading: Image.asset("assets/logo/visa.png", width: 45.w),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Customtext(
                        text: "Debit card",
                        color: selectedMethod == "Visa"
                            ? Colors.white
                            : Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      Customtext(
                        text: "3566 **** **** 0505",
                        color: selectedMethod == "Visa"
                            ? Colors.white70
                            : Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                  trailing: Radio<String>(
                    activeColor: Colors.white,
                    value: "Visa",
                    // ignore: deprecated_member_use
                    groupValue: selectedMethod,
                    // ignore: deprecated_member_use
                    onChanged: (v) => setState(() => selectedMethod = v!),
                  ),
                ),

                const Spacer(),
                Divider(thickness: 2.w),
                Gap(10.h),

                CheckData(
                  title: 'Total Price:',
                  value: "${finalTotal.toStringAsFixed(2)} EGP",
                ),

                Gap(20.h),

                CustomBottom(
                  text: "Continue",
                  onTap: () {
                    context.read<AddTocartCubit>().placeOrder(
                      paymentMethod: selectedMethod,
                      total: widget.tolalprice,
                    );
                  },
                ),

                Gap(20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
