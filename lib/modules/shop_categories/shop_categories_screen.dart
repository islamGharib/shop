import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/shared/component/components.dart';

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

Widget CategoryBuilderItem(CategoriesModel? category){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: ListView.separated(
      physics: BouncingScrollPhysics(),
      //scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => buildCategoryItem(category!.catDataModel.catDataList[index]),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: category!.catDataModel.catDataList.length,
    ),
  );
}
