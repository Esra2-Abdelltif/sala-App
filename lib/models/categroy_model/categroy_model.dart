class CategoriesDataModel {
  bool status;
  CategoriesData categoriesData;
  CategoriesDataModel.fromJson(Map<String, dynamic> categoriesjson) {
    status = categoriesjson["status"];
    categoriesData = CategoriesData.fromJson(categoriesjson["data"]);
  }
}

class CategoriesData {
  dynamic current_page;
  List<Data> data = [];
  CategoriesData.fromJson(Map<String, dynamic> jsondata) {
    current_page = jsondata["current_page"];
    jsondata["data"].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  dynamic id;
  String name;
  String image;
  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}
