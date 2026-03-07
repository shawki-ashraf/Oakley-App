import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImagesSlider extends StatefulWidget {
  final List<String> images;
  const ProductImagesSlider({super.key, required this.images});

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.h, // متجاوب مع أي شاشة
      child: Stack(
        children: [
          /// 🔹 الصور
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.network(
                  widget.images[index],
                  fit: BoxFit.contain, // يحافظ على شكل الصورة الطبيعي
                  width: double.infinity,
                  height: 400.h,
                ),
              );
            },
          ),

          /// 🔹 زر الرجوع فوق الصورة
          Positioned(
            top: 10.h,
            left: 16.w,
            child: SafeArea(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back, color: Colors.black, size: 28.sp),
              ),
            ),
          ),

          /// 🔹 dots indicator
          Positioned(
            bottom: 14.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: currentIndex == index ? 14.w : 7.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: currentIndex == index ? Colors.orange : Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
