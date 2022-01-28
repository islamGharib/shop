import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/shared/component/components.dart';

import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state){},
        builder: (context, state){
          SearchCubit searchResult = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: defaultTextFormField(
                controller: searchController,
                type: TextInputType.text,
                validate: (value){},
                onSubmit: (String value){
                    searchResult.getSearchResult(value);
                },
                label: 'Search',
                prefix: Icons.search,
            ),
          );
        },
      ),
    );
  }
}
