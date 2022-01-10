import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

