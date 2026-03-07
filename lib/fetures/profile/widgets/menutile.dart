import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? ontap;

  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h), // بدل 12
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r), // بدل 14
        border: Border.all(color: Colors.black26),
        color: Colors.white,
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black87, size: 24.sp), // بدل 24
        title: Text(
          title,
          style: TextStyle(fontSize: 16.sp), // بدل 16
        ),
        trailing: Icon(Icons.chevron_right, size: 24.sp),
        onTap: ontap,
      ),
    );
  }
}
