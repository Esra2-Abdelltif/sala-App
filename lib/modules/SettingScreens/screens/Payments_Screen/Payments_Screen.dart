import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/modules/SettingScreens/screens/Payments_Screen/visaCard.dart';
import 'package:salaa_app/shared/Styles/theme/cubit/cubit.dart';
import 'package:salaa_app/shared/compoenets/components.dart';

import '../../../../layout/Bloc/cubit.dart';
import '../../../../shared/Styles/colors.dart';

class PaymentsScreen extends StatefulWidget {
  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  var formkey =GlobalKey<FormState>();

  bool _secirty = true;
  bool value = false;


  @override
  Widget build(BuildContext context) {
    var CardNumberController = TextEditingController();
    var NameController = TextEditingController();
    var ExpiryDateController = TextEditingController();
    var CvvController = TextEditingController();
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return defultColor;
      }
      return defultColor;
    }


    return BlocProvider(
      create: (BuildContext context)=> AppCubit()..getCartData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener:(context, state) {} ,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Payments"),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: defultColor,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              centerTitle: true,
            ),
            body:  AppCubit.get(context).cartModel == null ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Center(
                child: const CircularProgressIndicator(),),
            ) : AppCubit.get(context).cartModel.data.cartItems.isEmpty ? Center(child: Text ('No product yet',style: TextStyle(color: defultColor,fontSize: 20)))
                : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildTotalPrice( AppCubit.get(context).cartModel.data, context),
                        SizedBox(height: 30,),
                        Row(
                    children: [
                    Column(
                      children: [
                      Icon(Icons.payment,color: defultColor,size: 30),
                    ],),
                    SizedBox(width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('Payments Mode',style: TextStyle(fontSize: 27),),
                        Text('Select Your by payments mode',style: TextStyle(fontSize: 15, color: Color(0xFF8D8E98)),)
                    ],)

              ]),
                        SizedBox(height: 30,),
                        //Card
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyText1,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CardNumberFormatter(),
                            ],
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color:defultColor ),
                                borderRadius: BorderRadius.circular(25.0),
                              ),

                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/800px-Mastercard-logo.svg.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Change',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'XXXX XXXX XXXX XXXX',
                              labelText: 'Card Number',

                              hintStyle: TextStyle(color: Color(0xFF8D8E98)),
                              labelStyle:TextStyle(color:defultColor),
                            ),
                            maxLength: 19,
                            onChanged: (value) {},
                          ),
                        ),

                        SizedBox(height: 10,),
                        //OR
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('OR ',style:TextStyle(fontWeight: FontWeight.w300,color: Color(0xFF8D8E98),)),

                          ],
                        ),
                        SizedBox(height: 20,),
                        //pay on delivery
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 70,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:ThemeAppCubit.get(context).IsDark ? Colors.grey[300] :Colors.black54
                                ),),
                              child: Row(children: [
                                SizedBox(width: 10),
                                Image.network(
                      'https://seeklogo.com/images/F/free-delivery-logo-3F8F5B428D-seeklogo.com.png',
                                  height: 35,
                                  width: 35,
                                ),
                                SizedBox(width: 15),
                                Text('pay on delivery',style: TextStyle(color: defultColor,fontSize: 20)),
                                Spacer(),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: this.value,
                                  onChanged: (bool value) {
                                    setState(() {
                                      this.value = value;
                                    });
                                  },
                                ),
                              ],)
                          ),
                        ),
                        SizedBox(height: 20,),
                        //Save
                        Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child:MaterialButton(color:defultColor,hoverColor: Colors.black,
                            onPressed: () {},
                            child:Text('Save',style: TextStyle(fontSize:18 ,),), ),
                        ),


            ],),
                  ),
                )
          );
        },

      ),
    );
  }

  Widget buildTotalPrice( model, context) => Container(
    width:250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
          width: 1,
          color:Colors.grey[300]
      ),
      color: defultColor,
      boxShadow: [
        BoxShadow(blurRadius: 1, color: Color(0xFF8D8E98),spreadRadius: 1.1),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(
          top: 15.0, bottom: 15.0),
      child: Center(
        child: Text(
          'Total  \$ ${model.total}',
          style: TextStyle(
            fontSize: 20.0,
            height: 1.2,
            // fontWeight: FontWeight.w900,
            //backgroundColor: Colors.yellow,
          ),
        ),
      ),
    ),
  );
}


