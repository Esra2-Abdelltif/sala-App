class ContactUsModel {
  bool status;
  Data data;

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  dynamic currentPage;
  List<ContactData> data=[];
  String firstPageUrl;
  dynamic from;
  dynamic lastPage;
  String lastPageUrl;
  Null nextPageUrl;
  String path;
  dynamic perPage;
  Null prevPageUrl;
  dynamic to;
  dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<ContactData>();
      json['data'].forEach((v) {
        data.add(new ContactData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}

class ContactData {
  dynamic id;
  dynamic type;
  String value;
  String image;

  ContactData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
    image = json['image'];
  }
}
