class SearchModel{
  bool status ;
  String? message;
  Data data;
  SearchModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'],
        data = json['data'] = Data.fromJson(json['data']);
}

class Data{
  int currentPage;
  List<ProductData> productDataList = [];
  int total;
  Data.fromJson(Map<String, dynamic> json)
      :  currentPage = json['current_page'],
        productDataList = getProducts(json),
        total = json['total'];
  static List<ProductData> getProducts(Map<String,dynamic> json){
    List<ProductData> productList = [];
    var productData = json['data'];
    for (var i in productData) {
      ProductData product = ProductData.fromJson(i);
      productList.add(product);
    }
    return productList;
  }
}

class ProductData{
  int id;
  String name;
  String image;
  dynamic price;

  ProductData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        price = json['price'];

}