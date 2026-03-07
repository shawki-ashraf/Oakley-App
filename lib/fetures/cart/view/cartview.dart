import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/fetures/cart/cubit/add_tocart_cubit.dart';
import 'package:furneture_app/fetures/cart/view/checkout_view.dart';
import 'package:furneture_app/fetures/cart/widgets/cartitem.dart';
import 'package:furneture_app/shared/Customtext.dart';
import 'package:furneture_app/shared/custom_bottom.dart';
import 'package:gap/gap.dart';

class Cartview extends StatefulWidget {
  const Cartview({super.key});

  @override
  State<Cartview> createState() => _CartviewState();
}

class _CartviewState extends State<Cartview> {
  @override
  void initState() {
    super.initState();
    context.read<AddTocartCubit>().listenToCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// TITLE
          Padding(
            padding: EdgeInsets.only(top: 60.h),
            child: Customtext(
              text: "My Cart",
              fontSize: 22.sp,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),

          Gap(20.h),

          /// CART LIST
          Expanded(
            child: BlocBuilder<AddTocartCubit, AddTocartState>(
              builder: (context, state) {
                if (state is CartError) {
                  return Center(
                    child: Text(state.msg, style: TextStyle(fontSize: 14.sp)),
                  );
                }

                if (state is CartLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CartLoaded) {
                  final data = state.items;

                  if (data.isEmpty) {
                    return Center(
                      child: Text(
                        "Your cart is empty",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(12.w),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return CartItem(
                        name: item.name,
                        dec: item.dec,
                        price: item.price,
                        quantity: 1,
                        image: item.image,
                        onDelete: () {
                          context.read<AddTocartCubit>().removeItem(
                            item.products_ID.toString(),
                          );
                        },
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),

          /// CHECKOUT BUTTON
          Padding(
            padding: EdgeInsets.all(16.w),
            child: BlocBuilder<AddTocartCubit, AddTocartState>(
              builder: (context, state) {
                double totalPrice = 0;

                if (state is CartLoaded) {
                  totalPrice = state.items.fold(
                    0,
                    (prev, item) => prev + item.price,
                  );
                }

                final bool isCartEmpty =
                    state is CartLoaded && state.items.isEmpty;

                return CustomBottom(
                  text: "Proceed to Checkout",
                  price: "${totalPrice.toStringAsFixed(2)} EGP",
                  onTap: isCartEmpty
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<AddTocartCubit>(),
                                child: CheckoutView(tolalprice: totalPrice),
                              ),
                            ),
                          );
                        },
                );
              },
            ),
          ),

          Gap(30.h),
        ],
      ),
    );
  }
}
