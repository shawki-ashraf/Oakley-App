import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({super.key});

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  int activeIndex = 0;

  final List<String> images = [
    "https://images.unsplash.com/photo-1503174971373-b1f69850bded?q=80&w=1213&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?q=80&w=1700&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1594026112284-02bb6f3352fe?q=80&w=1170&auto=format&fit=crop",
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // precache أول الصور عشان أول عرض يبقى smooth
    for (final url in images) {
      precacheImage(CachedNetworkImageProvider(url), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CachedNetworkImage(
                  imageUrl: images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 160.h,

                  // loading smooth
                  placeholder: (context, url) => Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),

                  // error handling
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, size: 24),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 160.h,
            viewportFraction: 1,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() => activeIndex = index);
            },
          ),
        ),

        SizedBox(height: 10.h),

        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: images.length,
          effect: ExpandingDotsEffect(
            dotHeight: 6.h,
            dotWidth: 6.w,
            activeDotColor: Colors.orange,
            dotColor: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}
