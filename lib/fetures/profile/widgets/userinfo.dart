import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 32.r, // بدل 32
          backgroundColor: const Color(0xffE0E0E0),
          child: Text(
            "I",
            style: TextStyle(
              fontSize: 26.sp, // بدل 26
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(width: 15.w), // بدل 15
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Shawki",
                style: TextStyle(
                  fontSize: 18.sp, // بدل 18
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h), // بدل 4
              Text(
                "shawki@gmail.com",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp, // ممكن تضيف حجم خط متجاوب
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.more_horiz,
          color: Colors.black54,
          size: 24.sp, // حجم الايقونة متجاوب
        ),
      ],
    );
  }
}
