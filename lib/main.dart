import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaa_app/layout/home_layout/home_layout.dart';
import 'package:salaa_app/layout/splash_screen/spalsh_screen.dart';
import 'package:salaa_app/modules/on_boarding_screen/on_boardin_screen.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Network/local/cacheHelper.dart';
import 'package:salaa_app/shared/Styles/theme/cubit/cubit.dart';
import 'package:salaa_app/shared/Styles/theme/cubit/states.dart';
import 'package:salaa_app/shared/Styles/theme/theme.dart';

import 'layout/Bloc/observer_bloc.dart';
import 'modules/search_screen/bloc/cubit.dart';
import 'modules/welcome_screen/welcome_screen.dart';
import 'package:salaa_app/layout/Bloc/cubit.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'shared/Network/remote/dio_helper.dart';

void main()  async {
  //بيتاكد ان كل حاجه في ميثود خلصت وبعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  await CacheHelper.init();

  bool IsDark =CacheHelper.getDate(key: 'IsDark');

  Widget RightScreen;
  //bool onBoarding =CacheHelper.getDate(key: 'onBoarding');
  //token =CacheHelper.getDate(key: 'token');
  print("onBoarding : ${onBoarding}");
  print("shoptoken : ${shoptoken}");

  if(onBoarding !=null)
  {
    if(shoptoken!=null){
      RightScreen= HomeLayout();
    }
    else{
      RightScreen =WelcomeScreen();}
  }
  else{
    RightScreen = OnBoardinScreen();
  }



  BlocOverrides.runZoned( () {
    runApp( MyApp(IsDark,RightScreen));

  },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool IsDark;
  // bool onBoarding;
  final Widget RightScreen;
  MyApp(this.IsDark,this.RightScreen);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => AppCubit()..getHomeData()..getFavoritesData()..getUserData()..getSettings()..getCategoriesData())),
        BlocProvider(create: (BuildContext context )=>ThemeAppCubit()..ChangeAppMode(fromShared: IsDark)),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),

      ],
      child: BlocConsumer<ThemeAppCubit,ThemeAppStates>(
        listener: (context ,state){},
        builder: (context ,state){
          return  MaterialApp(
            theme: lightthemes..bottomNavigationBarTheme,
            darkTheme: darkthemes..bottomNavigationBarTheme,
            themeMode: ThemeAppCubit.get(context).IsDark ? ThemeMode.light:ThemeMode.dark ,
            debugShowCheckedModeBanner: false,
            //home:RightScreen,
            home:SplashSCreen(),
          );
        },
      ),
    );
  }
}

