import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/constant/appcolors_const.dart';
import 'package:furneture_app/shared/Customtext.dart';

class BestSellersList extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  final String image;
  final String name;
  final double rate;
  final int price;
  final String catogery;
  final bool isFavorite;

  const BestSellersList({
    super.key,
    required this.onTap,
    required this.onFavorite,
    required this.image,
    required this.name,
    required this.rate,
    required this.price,
    required this.catogery,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r)),
      child: SizedBox(
        width: 270.w,
        height: 290.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            Stack(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(22.r),
                    ),
                    child: Image.network(
                      image,
                      height: 155.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// ❤️ FAVORITE BUTTON
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: GestureDetector(
                    onTap: onFavorite,
                    child: CircleAvatar(
                      radius: 17.r,
                      backgroundColor: Colors.white,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// CATEGORY + RATE
                  Row(
                    children: [
                      Expanded(
                        child: Customtext(
                          text: catogery,
                          fontSize: 12.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Customtext(
                        text: rate.toString(),
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                      SizedBox(width: 2.w),
                      Icon(Icons.star, size: 14.sp, color: Colors.amber),
                    ],
                  ),

                  SizedBox(height: 1.h),

                  /// NAME
                  Customtext(
                    text: name,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    maxLines: 1,
                    color: Colors.black,
                  ),

                  SizedBox(height: 1.h),

                  /// PRICE + ADD
                  Row(
                    children: [
                      Customtext(
                        text: "$price EGP",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        "${price + 50} EGP",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 17.r,
                        backgroundColor: AppcolorsConst.primery,
                        child: Icon(
                          Icons.add,
                          size: 18.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
