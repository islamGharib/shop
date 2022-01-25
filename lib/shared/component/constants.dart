import 'package:shop_app/modules/shop_login/shop_login_screen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';

dynamic token = CachHelper.getData(key: 'token');

void signOut(context){
  CachHelper.clearData(key: 'token').then((value) {
    if(value){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}