import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

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
class ShopFavoritesDataLoadingState extends ShopStates{}
class ShopFavoritesDataSuccessState extends ShopStates{}
class ShopFavoritesDataErrorState extends ShopStates{}
class ShopUserDataLoadingState extends ShopStates{}
class ShopUserDataSuccessState extends ShopStates{
  final ShopLoginModel model;
  ShopUserDataSuccessState(this.model);
}
class ShopUserDataErrorState extends ShopStates{}
class ShopUpdateUserDataLoadingState extends ShopStates{}
class ShopUpdateUserDataSuccessState extends ShopStates{
  final ShopLoginModel model;
  ShopUpdateUserDataSuccessState(this.model);
}
class ShopUpdateUserDataErrorState extends ShopStates{}