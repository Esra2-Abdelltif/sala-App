import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:salaa_app/modules/Register_Screens/login_screen/login_screen.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({@required this.image,@required this.title,@required this.body});
}
class OnBoardinScreen1 extends StatefulWidget {
  @override
  State<OnBoardinScreen1> createState() => _OnBoardinScreen1State();
}

class _OnBoardinScreen1State extends State<OnBoardinScreen1> {
  var boardController =PageController();

  List<BoardingModel> boarding =[
    BoardingModel(image:'assets/images/onboarding_1.png' , title: 'Screen Title1', body: 'Screen body1'),
    BoardingModel(image:'assets/images/onboarding_1.png' , title: 'Screen Title2', body: 'Screen body2'),
    BoardingModel(image:'assets/images/onboarding_1.png' , title: 'Screen Title3', body: 'Screen body1')
  ];
  bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            TextButton(onPressed:(){
              NavigateAndFinsh(context: context,router: LoginScreen());
            } , child:Text('Skip',style: TextStyle(fontSize: 20)))
          ],
        ),
        body:Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  onPageChanged: (int index){
                    if(index == boarding.length-1){
                      setState(() {
                        isLast=true;
                      });
                      print('last');
                    }
                    else {
                      setState(() {
                        isLast=false;
                      });
                      print('not last');

                    }
                  },
                  // physics: BouncingScrollPhysics(), //بتشيل اللون الي بيظهر في جنب لما بوصل للنهايه
                  itemBuilder: ((context, index) => BuildBoardingItem(boarding[index])),
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(height: 40,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(
                      controller: boardController,
                      count: boarding.length,
                      effect:  const JumpingDotEffect(
                        activeDotColor: defultColor,
                        dotHeight: 20,
                        dotWidth: 20,
                        jumpScale: .7,
                        //verticalOffset: 150,

                      ),
                    ),
                    const Spacer(),
                    Conditional.single(
                      context: context,
                      conditionBuilder:(BuildContext context)=> isLast,
                      widgetBuilder:  (BuildContext context){
                        return TextButton(onPressed:(){
                          NavigateAndFinsh(context: context,router: LoginScreen());
                        } , child:Text('Done',style: TextStyle(fontSize: 18),));
                      },
                      fallbackBuilder:  (BuildContext context){
                        return FloatingActionButton(onPressed: (){
                          if(isLast){
                            NavigateAndFinsh(router: LoginScreen(),context: context);
                          }
                          else{
                            boardController.nextPage(duration: const Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
                          }
                        },
                          child: const Icon(Icons.arrow_forward),);
                      },
                    )


                  ]
              ),
            ],),
        )
    );
  }

  Widget BuildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'))),
      const SizedBox(height: 10,),
      Center(child: Text('${model.title}',style: const TextStyle(fontSize: 24))),
      const SizedBox(height: 10,),
      Center(child: Text('${model.body}',style: const TextStyle(fontSize: 14))),
      const SizedBox(height: 10,),
    ],
  );
}