class ChangeCartsModel {
  bool status;
  String message;

  ChangeCartsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
