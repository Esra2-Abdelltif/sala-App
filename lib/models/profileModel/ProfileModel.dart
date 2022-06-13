class ProfileModel {
  bool status;
  Null message ;
  ProfileDate data ;
  ProfileModel.fromJson(Map <String,dynamic> userdata){
    status =userdata["status"];
    message=userdata["message"];
    data = (userdata["data"] != null) ? ProfileDate.fromJson(userdata["data"]) : null ;

  }

}

class ProfileDate {
  dynamic id ;
  String name ;
  String email ;
  String phone ;
  String image;
  dynamic points ;
  dynamic credit ;
  String token ;

  ProfileDate.fromJson(Map<String,dynamic> json){
    id =  json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"] ?? 0;
    credit = json["credit"] ?? 0;
    token = json["token"];
  }




}