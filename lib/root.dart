import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furneture_app/fetures/cart/cubit/add_tocart_cubit.dart';
import 'package:furneture_app/fetures/cart/view/cartview.dart';
import 'package:furneture_app/fetures/fave/cubit/fave_cubit.dart';
import 'package:furneture_app/fetures/fave/view/faveview.dart';
import 'package:furneture_app/fetures/home/cubit/homeproducts_cubit.dart';
import 'package:furneture_app/fetures/home/view/homeview.dart';
import 'package:furneture_app/fetures/profile/view/myorders.dart';
import 'package:furneture_app/fetures/profile/view/profileview.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const Homeview(),
    const Faveview(),
    const Cartview(),
    const MyOrdersView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeProductsCubit()..loadHomeData()),
        BlocProvider(create: (context) => FavoriteCubit()..listenFavorites()),
        BlocProvider(create: (context) => AddTocartCubit()),
      ],
      child: Scaffold(
        body: IndexedStack(index: currentIndex, children: pages),

        // نفس التصميم بالضبط 👇
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              // ignore: deprecated_member_use
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite),
                label: "favorite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                activeIcon: Icon(Icons.shopping_cart),
                label: "Cart",
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                activeIcon: Icon(Icons.receipt_long),
                label: "My Orders",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
