class UserDateModel {
  bool status;
  String message ;
  UserDate data ;
  UserDateModel.fromJson(Map <String,dynamic> userdata){
    status =userdata["status"];
    message=userdata["message"];
    data = (userdata["data"] != null) ? UserDate.fromJson(userdata["data"]) : null ;


  }

}

class UserDate {
   dynamic id ;
   String name ;
   String email ;
   String phone ;
   String image;
   dynamic points ;
   dynamic credit ;
   String token ;

   UserDate.fromJson(Map<String,dynamic> json){
     id =  json["id"];
     name = json["name"];
     email = json["email"];
     phone = json["phone"];
     image = json["image"];
     points = json["points"]  ??0;
     credit = json["credit"]??  0;
     token = json["token"];
   }




}