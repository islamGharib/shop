import 'dart:convert';

class CategoriesModel{
  bool status ;
  CategoryDataModel catDataModel;
  CategoriesModel.fromJson(Map<String, dynamic> json)
  : status = json['status'],
    catDataModel = CategoryDataModel.fromJson(json['data']);
}

class CategoryDataModel{
  int currentPage;
  List<CategoryData> catDataList = [];
  int total;
  CategoryDataModel.fromJson(Map<String,dynamic> json)
  :  currentPage = json['current_page'],
     catDataList = getCategories(json),
     total = json['total'];
  
  static List<CategoryData> getCategories(Map<String,dynamic> json){
    List<CategoryData> categoryList = [];
    var categoryData = json['data'];
    for (var i in categoryData) {
      CategoryData category = CategoryData.fromJson(i);
      categoryList.add(category);
    }
    return categoryList;
  }
}

class CategoryData{
  int id;
  String name;
  String image;
  CategoryData.fromJson(Map<String,dynamic> json)
  : id = json['id'],
    name = json['name'],
    image = json['image'];
}

