import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SerchView extends StatelessWidget {
  final ValueChanged<String>? onchanged;
  const SerchView({super.key, required this.onchanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: TextField(
          onChanged: onchanged,
          decoration: InputDecoration(
            hintText: "Search furniture...",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(
              CupertinoIcons.search,
              color: Colors.grey,
              size: 22.sp,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 12.w,
            ),
          ),
          style: TextStyle(fontSize: 14.sp, color: Colors.black),
        ),
      ),
    );
  }
}
