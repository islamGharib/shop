import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_provider.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CachHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: OnBoardingScreen(),
    );
  }
}

