import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salaa_app/shared/Styles/colors.dart';

//MaterialButton

Widget defultMaterialButton({
  double width,
  double height,
  Color backColor =defultColor,
  double borderRadius=25,
  double fontsize=20,
  Color ColorText : Colors.white,
  String text,
  VoidCallback function,
})=> Container(
  width: width,
  height: height,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
  clipBehavior: Clip.antiAliasWithSaveLayer,
  child:MaterialButton(color:backColor,hoverColor: Colors.black,
    onPressed: function,
    child:Text(text,style: TextStyle(fontSize:fontsize ,color:ColorText,),), ),
);


//TextFormField

Widget defulutTextFormFild ({
  TextEditingController controller,
  FormFieldValidator validator,
  TextInputType type,
  String labeltext,
  String hintText,
  IconData suffix,
  Widget prefix,
  bool obscureText,
  bool secirty,
  VoidCallback suffixFun,
  ValueChanged<String> onChanged,
  VoidCallback onTap,
  Function onSubmited,TextStyle style


})=>TextFormField(
  style: style,
  validator:validator,
  controller:controller,
  keyboardType: type,
  obscureText: obscureText,
  onChanged: onChanged,
  onFieldSubmitted: onSubmited,
  onTap: onTap,
  decoration: InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color:defultColor ),
      borderRadius: BorderRadius.circular(25.0),
    ),
    border:  OutlineInputBorder(),
    labelText: labeltext,

    hintText: hintText,
    hintStyle: TextStyle(color: Color(0xFF8D8E98)),

    labelStyle: TextStyle(color: defultColor),
    prefixIcon: prefix,
    suffixIcon: IconButton(icon: Icon(suffix,color: defultColor),
        onPressed:suffixFun ),




  ),


);

//TextButton
Widget defultTextButton({String text ,VoidCallback onPressed})=>
    TextButton(onPressed: onPressed,
        child: Text(text,));

//toast بيعرض رساله تسجيل الدخل سواء البايانات صح او غلط
Future<bool> showError({@required String massage ,@required ToastState state , int timeInSecForIosWeb , ToastGravity  gravity= ToastGravity.BOTTOM,Toast toastLength })=>
    Fluttertoast.showToast(
        msg: massage,
        toastLength:  toastLength,
        gravity:gravity,
        timeInSecForIosWeb:1,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );

enum ToastState {SUCCESS ,ERROR ,WARNING}
Color chooseToastColor(ToastState state){
  Color color;
  switch(state)
  {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.blue;
      break;

  }
  return color;
}

//خط فاصل
Widget MyDivider({double margin = 0.0,Colors bgColor}) => Container(
  color: Colors.grey[300],
  width: double.infinity,
  height: 1,
  padding: EdgeInsets.all(16.0),
  margin: EdgeInsets.symmetric(horizontal: margin),
);

const bgColor= Color(0xFF8D8E98);