import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';

class ShopLayoutScreen  extends StatelessWidget {
  const ShopLayoutScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoryData()..getFavoritesData()..getUserData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state){},
        builder: (context, state){
          ShopCubit shopCubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                shopCubit.titles[shopCubit.currentIndex],
              ),
              actions: [
                IconButton(
                  onPressed: (){},
                  icon: Icon(
                      Icons.search
                  ),
                ),
              ],
            ),
            body: shopCubit.screens[shopCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: shopCubit.currentIndex,
              onTap: (index){
                shopCubit.changeShopBottomNavigationIndex(index);
              },
              items: shopCubit.bottomNavItems,
            ),
          );
        },
      ),
    );
  }
}
