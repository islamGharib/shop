import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';

class ShopCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        ShopCubit shopCubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: shopCubit.categoriesModel != null && shopCubit.categoriesModel != null,
          builder: (context) => CategoryBuilderItem(shopCubit.categoriesModel),
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },

    );
  }
}


