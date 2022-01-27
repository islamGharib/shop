import 'package:shop_app/models/search_model.dart';

abstract class SearchStates{}
class SearchProductDataInitialState extends SearchStates{}
class SearchProductDataLoadingState extends SearchStates{}
class SearchProductDataSuccessState extends SearchStates{
  final SearchModel model;
  SearchProductDataSuccessState(this.model);
}
class SearchProductDataErrorState extends SearchStates{}