// model
import 'package:flutter/cupertino.dart';

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