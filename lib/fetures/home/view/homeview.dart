import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furneture_app/constant/appcolors_const.dart';
import 'package:furneture_app/fetures/fave/cubit/fave_cubit.dart';
import 'package:furneture_app/fetures/fave/cubit/fave_state.dart';
import 'package:furneture_app/fetures/home/cubit/homeproducts_cubit.dart';
import 'package:furneture_app/fetures/home/data/products_model.dart';
import 'package:furneture_app/fetures/home/view/productsdetails.dart';
import 'package:furneture_app/fetures/home/widgets/Best%20Sellers_list.dart';
import 'package:furneture_app/fetures/home/widgets/HomeHeader.dart';
import 'package:furneture_app/fetures/home/widgets/category.dart';
import 'package:furneture_app/fetures/home/widgets/grid_products.dart';
import 'package:furneture_app/fetures/home/widgets/pageview.dart';
import 'package:furneture_app/fetures/home/widgets/serch_view.dart';
import 'package:furneture_app/shared/Customtext.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  int selectedIndex = 0;

  final fakeProduct = ProductsModel(
    name: "Product Name",
    imageUrl: ["https://via.placeholder.com/300x400"],
    rate: 4.5,
    category: "Chair",
    price: 120,
    isbestSallers: true,
    dec: "Loading description",
    colors: "Brown",
    material: "Wood",
    products_ID: 0,
  );

  final fakeCategory = Catogerymodel(
    name: "Category",
    imageUrl: "https://via.placeholder.com/100",
  );

  @override
  void initState() {
    super.initState();
    context.read<HomeProductsCubit>().loadHomeData();
    context.read<FavoriteCubit>().listenFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffF4F4F4),
      body: BlocBuilder<HomeProductsCubit, HomeProductsState>(
        builder: (context, state) {
          final isLoading = state is HomeProductsLoading;

          final products = state is HomeProductsLoaded
              ? state.products
              : List.generate(6, (_) => fakeProduct);

          final bestSeller = state is HomeProductsLoaded
              ? state.bestsaller
              : List.generate(4, (_) => fakeProduct);

          final catogry = state is HomeProductsLoaded
              ? state.catogry
              : List.generate(5, (_) => fakeCategory);

          return Column(
            children: [
              /// الجزء الثابت: Welcome + Search + Banner
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(),
                    Gap(12.h),
                    SerchView(
                      onchanged: (String value) {
                        context.read<HomeProductsCubit>().searchProducts(value);
                      },
                    ),
                    Gap(12.h),
                  ],
                ),
              ),

              /// الجزء Scrollable: Categories + Best Sellers + All Products
              Expanded(
                child: Skeletonizer(
                  enabled: isLoading,
                  effect: ShimmerEffect(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: const HomeBannerSlider(),
                      ),

                      /// Categories
                      SizedBox(
                        height: 110.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: catogry.length,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemBuilder: (context, index) {
                            final data = catogry[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: CategoryItem(
                                title: data.name,
                                image: data.imageUrl,
                                isSelected: selectedIndex == index,
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      /// Best Sellers Title
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 20.h,
                        ),
                        child: Row(
                          children: [
                            Customtext(
                              text: "Best Sellers",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            const Spacer(),
                            Customtext(
                              text: "View all",
                              fontSize: 14.sp,
                              color: AppcolorsConst.primery,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),

                      /// Best Sellers List
                      SizedBox(
                        height: 270.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemCount: bestSeller.length,
                          itemBuilder: (context, index) {
                            final product = bestSeller[index];
                            return BlocBuilder<FavoriteCubit, FavoriteState>(
                              builder: (context, favState) {
                                bool isFavorite = false;
                                if (favState is FavoriteLoaded) {
                                  isFavorite = favState.favoriteIds.contains(
                                    product.products_ID.toString(),
                                  );
                                }
                                return Padding(
                                  padding: EdgeInsets.only(right: 12.w),
                                  child: BestSellersList(
                                    image: product.imageUrl.first,
                                    name: product.name,
                                    rate: product.rate,
                                    price: product.price,
                                    catogery: product.category,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ProductDetailsView(
                                            name: product.name,
                                            imagel: product.imageUrl,
                                            price: product.price,
                                            rate: product.rate,
                                            dec: product.dec,
                                            matrial: product.material,
                                            color: product.colors,
                                            products_ID: product.products_ID,
                                          ),
                                        ),
                                      );
                                    },
                                    onFavorite: () {
                                      context
                                          .read<FavoriteCubit>()
                                          .toggleFavorite(
                                            product.products_ID.toString(),
                                          );
                                    },
                                    isFavorite: isFavorite,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),

                      /// All Products Title
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 10.h),
                        child: Row(
                          children: [
                            Customtext(
                              text: "All Products",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            const Spacer(),
                            Customtext(
                              text: "View all",
                              fontSize: 14.sp,
                              color: AppcolorsConst.primery,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),

                      /// Grid
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.h,
                                crossAxisSpacing: 10.w,
                                childAspectRatio: 0.72,
                              ),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return BlocBuilder<FavoriteCubit, FavoriteState>(
                              builder: (context, favState) {
                                bool isFavorite = false;
                                if (favState is FavoriteLoaded) {
                                  isFavorite = favState.favoriteIds.contains(
                                    product.products_ID.toString(),
                                  );
                                }
                                return GridProducts(
                                  name: product.name,
                                  image: product.imageUrl.first,
                                  rate: product.rate.toString(),
                                  category: product.category,
                                  price: product.price,
                                  isFavorite: isFavorite,
                                  onFavoriteToggle: () {
                                    context
                                        .read<FavoriteCubit>()
                                        .toggleFavorite(
                                          product.products_ID.toString(),
                                        );
                                  },
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProductDetailsView(
                                          name: product.name,
                                          imagel: product.imageUrl,
                                          price: product.price,
                                          rate: product.rate,
                                          dec: product.dec,
                                          matrial: product.material,
                                          color: product.colors,
                                          products_ID: product.products_ID,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
