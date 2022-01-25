import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/component/components.dart';

class ShopSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state){},
        builder: (context, state){
          ShopLoginModel? userModel = ShopCubit.get(context).userDataModel;
          emailController.text = userModel!.data!.email;
          nameController.text = userModel.data!.name;
          phoneController.text = userModel.data!.phone;

          return ConditionalBuilder(
            condition: ShopCubit.get(context).userDataModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultTextFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validate:(value){
                        if (value == null || value.isEmpty){
                        return 'User name must not to be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(height: 20.0,),
                    defaultTextFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate:(value){
                        if (value == null || value.isEmpty){
                          return 'Email Address must not to be empty';
                        }
                        return null;
                      },
                      label: 'Email Address',
                      prefix: Icons.email,
                    ),
                    SizedBox(height: 20.0,),
                    defaultTextFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate:(value){
                        if (value == null || value.isEmpty){
                          return 'Phone Number must not to be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                  ]
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(),),
          );
        }
    );
  }
}

