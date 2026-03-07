import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/fetures/profile/cubit/profile_cubit.dart';
import 'package:furneture_app/fetures/profile/widgets/mycartitem.dart'
    show OrderHistoryCard;

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..listenOrders(),
      child: Scaffold(
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is Ordersloding) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrdersError) {
              return Center(
                child: Text(
                  state.msg,
                  style: TextStyle(color: Colors.red, fontSize: 16.sp),
                ),
              );
            } else if (state is Ordersloaded) {
              final orders = state.orders;

              if (orders.isEmpty) {
                return Center(
                  child: Text(
                    "You have no orders yet.",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 30.h,
                      horizontal: 16.w,
                    ),
                    child: Center(
                      child: Text(
                        "My Orders",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // القائمة (ListView)
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];

                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: OrderHistoryCard(
                            itemsCount: order.items.length,
                            totalPrice: order.total,
                            paymentMethod: order.paymentMethod,
                            createdAt: order.createdAt,
                            imageUrl:
                                "https://static.thenounproject.com/png/3157802-200.png",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
