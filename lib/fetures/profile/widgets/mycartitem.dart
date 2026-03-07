import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHistoryCard extends StatelessWidget {
  final int itemsCount; // عدد العناصر في الطلب
  final double totalPrice; // السعر الإجمالي
  final String paymentMethod; // طريقة الدفع
  final DateTime createdAt; // تاريخ إنشاء الطلب
  final String? imageUrl; // صورة الطلب (يمكن تكون ثابتة أو حسب الطلب)

  const OrderHistoryCard({
    super.key,

    required this.itemsCount,
    required this.totalPrice,
    required this.paymentMethod,
    required this.createdAt,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        "${createdAt.day}/${createdAt.month}/${createdAt.year}";

    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة الطلب
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(
                    imageUrl!,
                    width: 120.w,
                    height: 120.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 120.w,
                      height: 120.h,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported),
                    ),
                  )
                : Container(
                    width: 100.w,
                    height: 100.h,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image, color: Colors.white),
                  ),
          ),
          SizedBox(width: 12.w),
          // بيانات الطلب
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$itemsCount Items",
                  style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  "${totalPrice.toStringAsFixed(2)} EGY",
                  style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Payment: $paymentMethod",
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Date: $formattedDate",
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
