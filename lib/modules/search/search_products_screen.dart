import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state){
          if (state is SearchProductDataErrorState)
            showFlutterToast(
              message: 'No Result for this product',
              state: ToastStates.ERROR,
            );
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultTextFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value){
                        if (value == null || value.isEmpty){
                          return 'Enter text for searching';
                        }
                        return null;
                      },
                      onSubmit: (String value){
                        if(formKey.currentState!.validate())
                          SearchCubit.get(context).getSearchResult(value);
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    SizedBox(height: 10.0,),
                    if (state is SearchProductDataLoadingState)
                      LinearProgressIndicator(),
                    if (state is SearchProductDataSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => ProductItem(SearchCubit.get(context).searchResult!.data.productDataList[index], context, isSearched: true, searchedText: searchController.text),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: (SearchCubit.get(context).searchResult!.data.productDataList.length),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


