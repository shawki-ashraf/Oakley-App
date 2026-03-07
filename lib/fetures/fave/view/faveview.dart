import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:furneture_app/fetures/fave/cubit/fave_cubit.dart';
import 'package:furneture_app/fetures/fave/cubit/fave_state.dart';
import 'package:furneture_app/fetures/fave/widgets/fave_grid.dart';
import 'package:furneture_app/fetures/home/cubit/homeproducts_cubit.dart';

class Faveview extends StatefulWidget {
  const Faveview({super.key});

  @override
  State<Faveview> createState() => _FaveviewState();
}

class _FaveviewState extends State<Faveview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  "My Favorite",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Expanded(
              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, favState) {
                  if (favState is! FavoriteLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final favoriteIds = favState.favoriteIds;

                  return BlocBuilder<HomeProductsCubit, HomeProductsState>(
                    builder: (context, homeState) {
                      if (homeState is! HomeProductsLoaded) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final favoriteProducts = homeState.products
                          .where(
                            (p) =>
                                favoriteIds.contains(p.products_ID.toString()),
                          )
                          .toList();

                      if (favoriteProducts.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Favorites Yet",
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: favoriteProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.72,
                            ),
                        itemBuilder: (context, index) {
                          final product = favoriteProducts[index];

                          return FaveGrid(
                            name: product.name,
                            image: product.imageUrl.first,
                            isFavorite: true,
                            price: product.price.toString(),
                            onFavorite: () {
                              context.read<FavoriteCubit>().toggleFavorite(
                                product.products_ID.toString(),
                              );
                            },
                            dec: product.dec,
                            rate: product.rate.toString(),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
