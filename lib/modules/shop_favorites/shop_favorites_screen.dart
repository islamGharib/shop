import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopFavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        ShopCubit shopCubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopFavoritesDataLoadingState ,
          builder: (context) => FavoriteBuilderItem(shopCubit.favoritesModel, context),
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },

    );
  }
}

Widget FavoriteBuilderItem(FavoritesModel? model, context){
  return ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => ProductItem(model!.favDataModel.favDataList[index].favProductModel, context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: (model!.favDataModel.favDataList.length),
  );
}

