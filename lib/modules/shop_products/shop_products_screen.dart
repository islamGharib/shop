import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){
        if(state is ShopSuccessChangeFavoritesStates){
          if(!state.model.status){
            showFlutterToast(
                message: state.model.message,
                state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state){
        ShopCubit shopCubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: shopCubit.homeModel != null && shopCubit.categoriesModel != null,
          builder: (context) => ProductBuilderItem(shopCubit.homeModel, shopCubit.categoriesModel, context),
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },

    );
  }
}

Widget ProductBuilderItem(HomeModel? model, CategoriesModel? category, context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data.banners.map((e) =>
                  Image(image: NetworkImage('${e.image}'))
              ).toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,

              )
          ),
          SizedBox(height: 10.0,),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategoryItem(category!.catDataModel.catDataList[index]),
                    separatorBuilder: (context, index) => SizedBox(width: 10.0,),
                    itemCount: category!.catDataModel.catDataList.length,
                  ),
                ),
                SizedBox(height: 20.0,),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0,),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.51,
              children: List.generate(
                  model.data.products.length,
                      (index) => buildGridProduct(model.data.products[index], context)
              ),
            ),
          ),
        ],

      ),
    );

            // category item
Widget buildCategoryItem(CategoryData category){
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(category.image),
        height: 100,
        width: 100,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(0.7),
        child: Text(
          category.name,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

    ],
  );
}

          // Grid product
Widget buildGridProduct(ProductModel model, context){
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 200,
            ),
            if(model.discount != 0)
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  if(model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    padding: EdgeInsets.zero,
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: (ShopCubit.get(context).favorites[model.id])!? defaultColor: Colors.grey,
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
  );
}