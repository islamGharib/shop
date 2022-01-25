class FavoritesModel{
  bool status ;
  FavoriteDataModel favDataModel;
  FavoritesModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        favDataModel = FavoriteDataModel.fromJson(json['data']);
}

class FavoriteDataModel{
  int currentPage;
  List<FavoriteData> favDataList = [];
  int total;
  FavoriteDataModel.fromJson(Map<String, dynamic> json)
      :  currentPage = json['current_page'],
         favDataList = getFavorites(json),
         total = json['total'];

  static List<FavoriteData> getFavorites(Map<String,dynamic> json){
    List<FavoriteData> favoriteList = [];
    var favoriteData = json['data'];
    for (var i in favoriteData) {
      FavoriteData favorite = FavoriteData.fromJson(i);
      favoriteList.add(favorite);
    }
    return favoriteList;
  }

}


class FavoriteData{
  int id;
  FavoriteProductModel favProductModel;

  FavoriteData.fromJson(Map<String,dynamic> json)
      : id = json['id'],
        favProductModel = FavoriteProductModel.fromJson(json['product']);
}

class FavoriteProductModel{
  int id;
  String name;
  String image;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;

  FavoriteProductModel.fromJson(Map<String,dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        price = json['price'],
        oldPrice = json['old_price'],
        discount = json['discount'];


}
