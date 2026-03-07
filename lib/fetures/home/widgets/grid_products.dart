import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/constant/appcolors_const.dart';
import 'package:furneture_app/shared/Customtext.dart';

class GridProducts extends StatelessWidget {
  final String name;
  final String image;
  final String rate;
  final String category;
  final int price;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const GridProducts({
    super.key,
    required this.name,
    required this.image,
    required this.rate,
    required this.category,
    required this.price,
    required this.onTap,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(.05),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          Stack(
            children: [
              GestureDetector(
                onTap: onTap,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  child: Image.network(
                    image,
                    height: 120.h,
                    width: double.infinity,
                    fit: BoxFit.cover, // يحافظ على شكل الصورة الطبيعي
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// CONTENT
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// category + rate
                Row(
                  children: [
                    Expanded(
                      child: Customtext(
                        text: category,
                        fontSize: 11.sp,
                        color: const Color(0xff646464),
                        maxLines: 1,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Customtext(
                      text: "⭐ $rate",
                      fontSize: 11.sp,
                      color: const Color(0xff646464),
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                /// NAME
                Customtext(
                  text: name,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  maxLines: 1,
                ),

                SizedBox(height: 8.h),

                /// price + add
                Row(
                  children: [
                    Customtext(
                      text: "$price EGP",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.add_circle,
                      color: AppcolorsConst.primery,
                      size: 20.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
