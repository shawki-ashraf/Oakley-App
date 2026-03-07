import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/constant/appcolors_const.dart';
import 'package:furneture_app/fetures/cart/cubit/add_tocart_cubit.dart';
import 'package:furneture_app/fetures/cart/model/cartitem_model.dart';
import 'package:furneture_app/shared/Customtext.dart';
import 'package:furneture_app/shared/custom_bottom.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsView extends StatefulWidget {
  final String name;
  final List<String> imagel;
  final int price;
  final double rate;
  final String dec;
  final String matrial;
  final String color;
  final int products_ID;

  const ProductDetailsView({
    super.key,
    required this.name,
    required this.imagel,
    required this.price,
    required this.rate,
    required this.dec,
    required this.matrial,
    required this.color,
    required this.products_ID,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTocartCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xffF4F4F4),
        body: CustomScrollView(
          slivers: [
            // 🔹 SliverAppBar مع الصورة
            SliverAppBar(
              expandedHeight: 360.h,
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: EdgeInsets.all(8.w),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: widget.imagel.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          widget.imagel[index],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    // Dots Indicator
                    Positioned(
                      bottom: 10.h,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: widget.imagel.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: AppcolorsConst.primery,
                          dotColor: Colors.white54,
                          dotHeight: 8.h,
                          dotWidth: 8.w,
                          spacing: 6.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🔹 المحتوى تحت الصورة
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xffF4F4F4),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم المنتج + stock
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Customtext(
                          text: widget.name,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        Customtext(
                          text: "In Stock",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // السعر + خصم + rating
                    Row(
                      children: [
                        Customtext(
                          text: "${widget.price} EGY",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppcolorsConst.primery,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "80 EGY",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(.1),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            "-40% off",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.star, color: Colors.amber, size: 18.sp),
                        SizedBox(width: 4.w),
                        Customtext(
                          text: "${widget.rate}",
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),

                    SizedBox(height: 30.h),

                    // الوصف
                    Customtext(
                      text: "Description",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      widget.dec,
                      style: TextStyle(
                        color: Colors.grey,
                        height: 1.6,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 50.h),

                    // زر Add to Cart
                    BlocConsumer<AddTocartCubit, AddTocartState>(
                      listener: (context, state) {
                        if (state is CartActionSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green.shade600,
                              elevation: 6,
                              margin: EdgeInsets.all(16.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              duration: const Duration(seconds: 2),
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 12.w),
                                  const Expanded(
                                    child: Text(
                                      "Added To Cart successfully",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (state is CartActionError) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(state.msg)));
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is CartActionLoading;
                        return CustomBottom(
                          text: "Added To Cart ",
                          price: "${widget.price} EGY",
                          isLoading: isLoading,
                          onTap: () {
                            if (isLoading) return;

                            final data = CartitemModel(
                              name: widget.name,
                              price: widget.price,
                              dec: widget.dec,
                              image: widget.imagel[0],
                              products_ID: widget.products_ID,
                            );
                            context.read<AddTocartCubit>().addToCart(data);
                          },
                        );
                      },
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
