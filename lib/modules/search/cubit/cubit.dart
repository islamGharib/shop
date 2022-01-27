import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchProductDataInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchResult;
  void getSearchResult(String text){
    emit(SearchProductDataLoadingState());
    DioHelper.postData(
      url: SEARCH,
      data: {'text' : text,},
      token: token,
    ).then((value) {
      searchResult = SearchModel.fromJson(value.data);
      print(searchResult!.data.productDataList[0].name);
      emit(SearchProductDataSuccessState(searchResult!));
    }).catchError((error){
      print(error.toString());
      emit(SearchProductDataErrorState());
    });
  }

}