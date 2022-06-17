
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:salaa_app/modules/Register_Screens/login_screen/login_screen.dart';
import 'package:salaa_app/modules/Register_Screens/welcome_screen/welcome_screen.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Network/local/cacheHelper.dart';
import 'package:salaa_app/shared/Styles/colors.dart';
import 'package:salaa_app/shared/Styles/size_config.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({@required this.image,@required this.title,@required this.body});
}
class OnBoardinScreen extends StatefulWidget {
  @override
  State<OnBoardinScreen> createState() => _OnBoardinScreenState();
}

class _OnBoardinScreenState extends State<OnBoardinScreen> {
  var boardController =PageController();
  //لو عاوزه اخلي لي كل صفحه لون مختلف
 // int _currentPage = 0;
  // List colors = [Color(0xffDAD3C8), Color(0xffFFE5DE), Color(0xffDCF6E6)];
void Onsubmit(){
  CacheHelper.saveDate(key:'onBoarding', value: true).then((value) =>
      NavigateAndFinsh(router:WelcomeScreen(),context: context)
  );
}
  List<BoardingModel> boarding =[
    BoardingModel(image:'assets/images/onboarding_1.png' ,
        title: 'Online Shopping',
        body: 'You can shopping anytime, anywhere that you want.'),
    BoardingModel(image:'assets/images/onboarding_2.png' , title: 'Mobile Payment',
        body: 'Download our shopping application and buy using your smartphone or laptop.'),
    BoardingModel(image:'assets/images/onboarding_3.png' ,
        title: 'Delivery Service',
        body: 'Modern delivering technologies.The products you order will be delivered to your address.')
  ];
  bool isLast=false;
  bool isFirst=false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW;
    double height = SizeConfig.screenH;
    double blockH = SizeConfig.blockH;
    double blockV = SizeConfig.blockV;
    return Scaffold(
      //backgroundColor: colors[_currentPage],
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: boardController,
             onPageChanged: (int index){
              // _currentPage =index;
                if(index == boarding.length-1){
                  setState(() {
                    isLast=true;
                    isFirst=false;
                  });
                  print('last');
                  print('not first ');

                }
                else if( index == 0){
                  setState(() {
                    isLast=false;
                    isFirst=true;
                  });
                  print('not last');
                  print('first');


                }
                else {
                  setState(() {
                    isLast=false;
                    isFirst=false;
                  });
                }
             },
             // physics: BouncingScrollPhysics(), //بتشيل اللون الي بيظهر في جنب لما بوصل للنهايه
              itemBuilder: ((context, index) => BuildBoardingItem(boarding[index])),
              itemCount: boarding.length,
            ),
          ),
            const SizedBox(height: 40,),
            Expanded(
              flex: 1,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        SmoothPageIndicator(
                        controller: boardController,
                        count: boarding.length,
                        effect:  const ExpandingDotsEffect(
                          activeDotColor: defultColor,
                          dotHeight: 16,
                          dotWidth: 16,
                          //jumpScale: .7,
                          //verticalOffset: 150,

                        ),
                      ),
                      ]
                    ),
                    isLast
                        ? Padding(
                      padding: const EdgeInsets.all(30),
                      child: ElevatedButton(
                        onPressed: () {
                          //bt3ml save lw tm el tsgel
                          CacheHelper.saveDate(key:'onBoarding', value: true).then((value) =>
                              NavigateAndFinsh(router:const WelcomeScreen(),context: context)
                          );

                        },
                        child: Text("Start"),
                        style: ElevatedButton.styleFrom(
                          primary: defultColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: (width <= 550) ? EdgeInsets.symmetric(
                              horizontal: 80, vertical: 20) : EdgeInsets.symmetric(horizontal: width * 0.2, vertical: 25),
                          textStyle: TextStyle(fontSize: (width <= 550) ? 13 : 17),
                        ),
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.all(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              boardController.jumpToPage(2);
                            },
                            child: Text(
                              "SKIP",

                            ),
                            style: TextButton.styleFrom(
                              elevation: 0,
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: (width <= 550) ? 14 : 17,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              boardController.nextPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              );
                            },
                            child: Text("NEXT"),
                            style: ElevatedButton.styleFrom(
                              primary:defultColor,
                              shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              elevation: 0,
                              padding: (width <= 550)
                                  ? EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20)
                                  : EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 25),
                              textStyle: TextStyle(
                                  fontSize: (width <= 550) ? 13 : 17),
                            ),
                          ),
                        ],
                      ),
                    )


                  ]
              ),
            ),
        ],),
      )
    );
  }

  Widget BuildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'),height: SizeConfig.blockV * 35,)),
      const SizedBox( height: 30,),
      Center(child: Text('${model.title}',textAlign: TextAlign.center,style: const TextStyle(fontSize: 30, color: Colors.black54, fontWeight: FontWeight.w600,),)),
      const SizedBox(height: 10,),
      Center(child: Text('${model.body}',textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.w300,color: Color(0xFF8D8E98),
          fontSize: 17 ))),
      const SizedBox(height: 10,),
    ],
  );
}
