import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/shared/Customtext.dart';
import 'package:gap/gap.dart';

class CartItem extends StatefulWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  final String name;
  final String dec;
  final int price;
  final int quantity;
  final String image;

  const CartItem({
    super.key,
    this.onDelete,
    this.onIncrease,
    this.onDecrease,
    required this.name,
    required this.dec,
    required this.price,
    required this.quantity,
    required this.image,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade300, width: 1.5.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: widget.image.isNotEmpty
                ? Image.network(
                    widget.image,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100.w,
                        height: 100.h,
                        color: Colors.grey.shade300,
                        child: Icon(Icons.broken_image, size: 24.sp),
                      );
                    },
                  )
                : Container(
                    width: 100.w,
                    height: 100.h,
                    color: Colors.grey.shade300,
                    child: Icon(Icons.image_not_supported, size: 24.sp),
                  ),
          ),

          Gap(12.w),

          /// DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Customtext(
                  text: widget.name,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  maxLines: 1,
                ),
                SizedBox(height: 4.h),
                Customtext(
                  text: widget.dec,
                  maxLines: 2,
                  fontSize: 12.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 6.h),

                /// PRICE × QUANTITY
                Customtext(
                  text: "${widget.price * widget.quantity} EGY",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ],
            ),
          ),

          /// RIGHT SIDE
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: widget.onDelete,
                icon: Icon(
                  CupertinoIcons.delete,
                  color: Colors.red,
                  size: 22.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
