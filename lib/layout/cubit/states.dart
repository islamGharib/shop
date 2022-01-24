import 'package:shop_app/models/change_favorites_model.dart';

abstract class ShopStates{}
class ShopinitialState extends ShopStates{}
class ShopChangeNavigationBarState extends ShopStates{}
class ShopHomeDataLoadingState extends ShopStates{}
class ShopHomeDataSuccessState extends ShopStates{}
class ShopHomeDataErrorState extends ShopStates{}
class ShopCategoriesDataSuccessState extends ShopStates{}
class ShopCategoriesDataErrorState extends ShopStates{}
class ShopChangeFavoritesState extends ShopStates{}
class ShopSuccessChangeFavoritesStates extends ShopStates{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesStates(this.model);
}
class ShopErrorChangeFavoritesStates extends ShopStates{}
class ShopFavoritesDataSuccessState extends ShopStates{}
class ShopFavoritesDataErrorState extends ShopStates{}