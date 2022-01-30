import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';
void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget,),
      (route) => false,
);

Widget defaultButton({
  double width = double.infinity,
  Color backgroundColor = defaultColor,
  bool isUpper = true,
  double radius = 0.0,
  required void Function()? buttonPressed,
  required String text ,

}) => Container(
  width: width,
  child: MaterialButton(
    onPressed: buttonPressed,
    child: Text(
      isUpper?text.toUpperCase():text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: backgroundColor,
  ),
);

Widget defaultTextButton({
  required void Function()? func,
  required String text ,
}) => TextButton(
  onPressed: func,
  child: Text(text.toUpperCase()),
);

// Text Form Field
Widget defaultTextFormField(
    {
      required final TextEditingController? controller,
      required TextInputType type,
      required  String? Function(String?)? validate,
      required String label,
      required IconData prefix,
      bool isPassword = false,
      IconData? suffix,
      Function()? suffixPressed,
      Function()? onTap,
      Function(String)? onChange,
      Function(String)? onSubmit,

    }) => TextFormField(
    controller: controller,
    keyboardType: type,
    validator: validate,
    obscureText: isPassword,
    onTap: onTap,
    onChanged: onChange,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(
          prefix
      ),
      suffixIcon: suffix != null?IconButton(
          onPressed: suffixPressed,
          icon: Icon(suffix,)):null,
      border: OutlineInputBorder(),
    )
);



Widget myDivider() =>
    Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void showFlutterToast({
  required String message,
  required ToastStates state,
}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum ToastStates{SUCCESS, ERROR, WARNING}
Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS : color = Colors.green; break;
    case ToastStates.ERROR : color = Colors.red; break;
    case ToastStates.WARNING : color = Colors.amber; break;
  }
  return color;
}

Widget ProductItem(model, context, {isSearched = false, searchedText = ''}){
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
                image: NetworkImage(model.image),
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
              if(isSearched == false)
                if (model.discount != 0)
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
                  model.name,
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
                      '${model.price.round()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    if(isSearched == false)
                      if (model.discount != 0)
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
                        if(isSearched){
                          ShopCubit.get(context).changeFavorites(model.id);
                          SearchCubit.get(context).getSearchResult(searchedText);
                        }
                        else
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
    ),
  );
}
