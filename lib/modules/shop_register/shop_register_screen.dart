import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_login/shop_login_screen.dart';
import 'package:shop_app/shared/component/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
        listener: (context, state){
          if(state is ShopRegisterSuccessState){
            if(state.registerModel.status){
              print(state.registerModel.message);
              print(state.registerModel.data!.token);
              showFlutterToast(
                message: state.registerModel.message!,
                state: ToastStates.SUCCESS,
              );
              navigateAndFinish(context, ShopLoginScreen());
            }else{
              print(state.registerModel.message);
              showFlutterToast(
                message: state.registerModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context,state){
          ShopRegisterCubit registerCubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),

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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 40,),
                        defaultTextFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (value){
                            if (value == null || value.isEmpty){
                              return 'User name must not to be empty';
                            }
                            return null;
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(height: 15,),
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
                          isPassword: registerCubit.isPassword,
                          validate: (value){
                            if (value == null || value.isEmpty){
                              return 'Password must not to be empty';
                            }
                            return null;
                          },
                          suffixPressed: (){
                            registerCubit.changePasswordVisibility();
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: registerCubit.suffix,
                        ),

                        SizedBox(height: 15,),
                        defaultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value){
                            if (value == null || value.isEmpty){
                              return 'phone must not to be empty';
                            }
                            return null;
                          },
                          onSubmit: (value){
                            if(formKey.currentState!.validate()){
                              registerCubit.userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passController.text,
                                  phone: phoneController.text
                              );
                            }
                          },
                          label: 'phone',
                          prefix: Icons.phone,
                        ),

                        SizedBox(height: 15,),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            buttonPressed: (){
                              if(formKey.currentState!.validate()){
                                print(emailController.text);
                                print(passController.text);
                                registerCubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passController.text,
                                    phone: phoneController.text
                                );
                              }

                            },
                            text: 'Register',
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator(),),
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
