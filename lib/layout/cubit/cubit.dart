import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/shop_categories/shop_categories_screen.dart';
import 'package:shop_app/modules/shop_favorites/shop_favorites_screen.dart';
import 'package:shop_app/modules/shop_products/shop_products_screen.dart';
import 'package:shop_app/modules/shop_settings/shop_settings_screen.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopinitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    ShopProductsScreen(),
    ShopCategoriesScreen(),
    ShopFavoritesScreen(),
    ShopSettingsScreen(),
  ];

  List<String> titles = [
    'Products',
    'Categories',
    'Favorites',
    'Settings'
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.category),
        label: 'Categories'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favorites'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings'
    ),
  ];
  void changeShopBottomNavigationIndex(int index){
    currentIndex = index;
    emit(ShopChangeNavigationBarState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData(){
    emit(ShopHomeDataLoadingState());
    DioHelper.getData(
        url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.data.products[0].image);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id:element.inFavorite
        });
      });
      //print(favorites.toString());
      emit(ShopHomeDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopHomeDataErrorState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoryData(){
    //emit(ShopHomeDataLoadingState());
    DioHelper.getData(
      url: GET_CATEGORIES,
      //token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print('${categoriesModel!.catDataModel.total}');
      emit(ShopCategoriesDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopCategoriesDataErrorState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId){
    favorites[productId] = !(favorites[productId]!);
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITE,
        data: {'product_id' : productId},
        token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(!(changeFavoritesModel!.status)){
        favorites[productId] = !(favorites[productId]!);
      }else{
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorChangeFavoritesStates());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData(){
    emit(ShopFavoritesDataLoadingState());
    DioHelper.getData(
      url: FAVORITE,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print('${favoritesModel!.favDataModel.total}');
      emit(ShopFavoritesDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopFavoritesDataErrorState());
    });
  }


  ShopLoginModel? userDataModel;
  void getUserData(){
    emit(ShopUserDataLoadingState());
    DioHelper.getData(
        url: PROFILE,
        token: token,
        ).then((value) async {
      userDataModel = ShopLoginModel.fromJson(value.data);
      print(userDataModel!.data!.name);
      emit(ShopUserDataSuccessState(userDataModel!));
    }).catchError((error){
      print(error.toString());
    });

  }




}