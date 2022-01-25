import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_layout_Screen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {

  var emailController = TextEditingController();

  var passController = TextEditingController();

  final formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener: (context, state){
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status){
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CachHelper.saveData(key: 'token', value: state.loginModel.data!.token);
              navigateAndFinish(context, ShopLayoutScreen());
            }else{
              print(state.loginModel.message);
              showFlutterToast(
                message: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context,state){
          ShopLoginCubit loginCubit = ShopLoginCubit.get(context);
          return Scaffold(

            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 40,),
                        defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if (value == null || value.isEmpty){
                              return 'Email must not to be empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                        ),
                        SizedBox(height: 15,),
                        defaultTextFormField(
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          isPassword: loginCubit.isPassword,
                          validate: (value){
                            if (value == null || value.isEmpty){
                              return 'Password must not to be empty';
                            }
                            return null;
                          },
                          suffixPressed: (){
                            loginCubit.changePasswordVisibility();
                          },
                          onSubmit: (value){
                            if(formKey.currentState!.validate()){
                              print(emailController.text);
                              print(passController.text);
                              loginCubit.userLogin(
                                  email: emailController.text,
                                  password: passController.text
                              );
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: loginCubit.suffix,
                        ),

                        SizedBox(height: 15,),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            buttonPressed: (){
                              if(formKey.currentState!.validate()){
                                print(emailController.text);
                                print(passController.text);
                                loginCubit.userLogin(
                                    email: emailController.text,
                                    password: passController.text
                                );
                              }

                            },
                            text: 'Login',
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator(),),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              func: (){},
                              text: 'register',
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),

          );
        },
      ),
    );
  }
}
