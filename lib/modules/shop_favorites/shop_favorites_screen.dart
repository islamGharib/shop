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
    itemBuilder: (context, index) => FavoriteItem(model!.favDataModel.favDataList[index].favProductModel, context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: (model!.favDataModel.favDataList.length),
  );
}

Widget FavoriteItem(FavoriteProductModel favorite, context){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(favorite.image),
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
              if(favorite.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favorite.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${favorite.price.round()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    if(favorite.discount != 0)
                      Text(
                        '${favorite.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(favorite.id);
                      },
                      padding: EdgeInsets.zero,
                      icon: CircleAvatar(
                        radius: 15.0,
                        //backgroundColor: (ShopCubit.get(context).favorites[model.id])!? defaultColor: Colors.grey,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )

        ],
      ),
    ),
  );
}
