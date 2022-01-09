// model
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_login/shop_login_screen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}

// design item
Widget buildBoardingItem(BoardingModel model) =>
    Column(
      children: [
        Image(
          image: AssetImage('${model.image}'),
        ),
        SizedBox(height: 30.0,),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        SizedBox(height: 15,),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 30.0,)
      ],
    );

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      title: 'OnBoard 1 title',
      image: 'assets/images/onboard_1.jpg',
      body: 'OnBoard 1 body',
    ),
    BoardingModel(
      title: 'OnBoard 2 title',
      image: 'assets/images/onboard_1.jpg',
      body: 'OnBoard 2 body',
    ),
    BoardingModel(
      title: 'OnBoard 3 title',
      image: 'assets/images/onboard_1.jpg',
      body: 'OnBoard 3 body',
    ),
  ];

  bool isLast = false;

  void submit(){
    CachHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){
              submit();
            },
            child: Text('SKIP'),
          ),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  itemCount: 3,
                  onPageChanged: (int index){
                    if(index == boarding.length - 1){
                      setState(() {
                        isLast = true;
                      });
                    }else{
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index){
                    return buildBoardingItem(boarding[index]);
                  }
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10.0,
                    spacing: 5.0,
                  ),
                  controller: boardController,
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }else{
                      boardController.nextPage(
                        duration: Duration(
                          microseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
