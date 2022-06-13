import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salaa_app/modules/login_screen/cubit/cubit.dart';
import 'package:salaa_app/modules/login_screen/login_screen.dart';
import 'package:salaa_app/modules/signup_screen/cubit/cubit.dart';
import 'package:salaa_app/modules/signup_screen/cubit/state.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Network/local/cacheHelper.dart';

import '../../layout/home_layout/home_layout.dart';
import '../../shared/Styles/colors.dart';
import '../../shared/compoenets/components.dart';
import '../login_screen/cubit/state.dart';

class SignupScreen extends StatelessWidget {
  var formkey =GlobalKey<FormState>();
  bool _secirty = true;
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SignUpCubit(),
        child: BlocConsumer<SignUpCubit, SignUpStates>(
            listener: (BuildContext context,  state) {
              if(state is SignUpSuccessState)
              {
                if(state.loginModel.status)
                {
                  showError(massage: state.loginModel.message ,
                      state: ToastState.SUCCESS,
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG);
                  CacheHelper.saveDate(key: 'token', value: state.loginModel.data.token).then((value)  {
                    token =  state.loginModel.data.token;
                    NavigateAndFinsh(context: context,router: HomeLayout());
                  });
                }
                else{
                  showError(massage: state.loginModel.message ,
                      state: ToastState.ERROR,
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG);
                }
              }
            },
            builder: (BuildContext context,   state) {
              return Scaffold(
                  body: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Form(
                          key: formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Sign Up Now ',
                                style: TextStyle(fontSize: 30, color: Colors.black54, fontWeight: FontWeight.w600),),
                              Text('login now to browse our hot offers',
                                  style:TextStyle(fontWeight: FontWeight.w300,color: Color(0xFF8D8E98),)),
                              SizedBox(
                                height: 40,),
                              //name
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25,),
                                child: defulutTextFormFild(
                                  style: Theme.of(context).textTheme.bodyText2,
                                  controller:nameController,
                                  type: TextInputType.text,
                                  labeltext: 'Name',
                                  hintText: 'Enter Full Name',
                                  obscureText: !_secirty,
                                  prefix: Icon(Icons.person, color: defultColor,),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }

                                    return null;

                                  },

                                ),
                              ),
                              SizedBox(
                                height:  20,),
                              //email
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25,),
                                child: defulutTextFormFild(
                                  style: Theme.of(context).textTheme.bodyText2,
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  labeltext: 'Email Adress',
                                  hintText: 'Enter Email Adress',
                                  obscureText: !_secirty,
                                  prefix: Icon(Icons.email, color: defultColor,),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                      return 'Please a valid Email';
                                    }
                                    return null;

                                  },

                                ),
                              ),
                              SizedBox(
                                height:  20,),
                              //phone
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25,),
                                child: defulutTextFormFild(
                                    style: Theme.of(context).textTheme.bodyText2,
                                    controller:phoneController,
                                    type: TextInputType.phone,
                                    labeltext: 'Phone',
                                    hintText: 'Enter your phone',

                                    onSubmited: (value){
                                      if (formkey.currentState.validate()){

                                      }
                                    },
                                    prefix: Icon(Icons.phone, color: defultColor,),


                                    obscureText: !_secirty,

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      if(value.length ==10)
                                      {
                                        return 'Please right number';
                                      }
                                      return null;}

                                ),
                              ),
                              SizedBox(
                                height: 20,),
                              //pass
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25,),
                                child: defulutTextFormFild(
                                    style: Theme.of(context).textTheme.bodyText2,
                                    controller: passController,
                                    type: TextInputType.text,
                                    labeltext: 'Password',
                                    hintText: 'Enter Password',

                                    onSubmited: (value){
                                      if (formkey.currentState.validate()){

                                      }
                                    },
                                    prefix: Icon(Icons.lock, color: defultColor,),
                                    suffix: SignUpCubit.get(context).suffix,
                                    suffixFun: (){
                                    SignUpCubit.get(context).ChangePasswordVisibility();

                                    },
                                    obscureText: SignUpCubit.get(context).secirty,

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      if(value.length <=5)
                                      {
                                        return 'Please enter long password';
                                      }
                                      return null;}

                                ),
                              ),
                              SizedBox(
                                height: 20,),
                              ConditionalBuilder(
                                condition:state is! SignUpLoadingState,
                                builder: (context) => defultMaterialButton(height: 50, width: 250,text: 'SignUp',
                                  function:(){
                                    if (formkey.currentState.validate()){
                                      print(passController.text);
                                      SignUpCubit.get(context).UserSignUp(email: emailController.text,
                                          password: passController.text,
                                          name:nameController.text,
                                          phone: phoneController.text);


                                      //NavigateTo(router:WelcomeScreen(),context: context);
                                    }
                                  },
                                ),
                                fallback: (context) => CircularProgressIndicator(),
                              ),
                              SizedBox(height: 15,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Already have an account ?',style:TextStyle(fontWeight: FontWeight.w300,color: Color(0xFF8D8E98),)),
                                  defultTextButton(text: 'LogIn', onPressed:() {
                                    NavigateTo(router:LoginScreen(),context: context);

                                  },),

                                ],
                              ),







                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              );
            }
        )
    );
  }
}
