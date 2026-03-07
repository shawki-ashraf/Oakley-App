import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/shared/Customtext.dart';
import 'package:gap/gap.dart';

class FaveGrid extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final VoidCallback onFavorite;
  final bool isFavorite;
  final String dec;
  final String rate;

  const FaveGrid({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.onFavorite,
    required this.isFavorite,
    required this.dec,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE + FAVORITE
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  image,
                  height: 130.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// ❤️ Favorite Button
              Positioned(
                top: 8.h,
                right: 8.w,
                child: GestureDetector(
                  onTap: onFavorite,
                  child: Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Gap(10.h),

          /// NAME
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Customtext(
              text: name,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          Gap(4.h),

          /// PRICE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Customtext(
              text: "$price EGY",
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff646464),
            ),
          ),

          Gap(4.h),

          /// PRICE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Customtext(
              text: dec,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff646464),
            ),
          ),

          Gap(4.h),

          /// PRICE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Customtext(
              text: "$rate⭐",
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff646464),
            ),
          ),
        ],
      ),
    );
  }
}
