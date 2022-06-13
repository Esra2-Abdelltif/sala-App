import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaa_app/models/categroy_model/categroy_model.dart';
import 'package:salaa_app/layout/Bloc/cubit.dart';
import 'package:salaa_app/layout/Bloc/states.dart';
import 'package:salaa_app/modules/CategoriesScreens/CategoriesDetails_Screeen/CategoriesDetails_Screen.dart';
import 'package:salaa_app/shared/Constans/constans.dart';
import 'package:salaa_app/shared/Styles/colors.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AppCubit,AppStates>(
          listener: (BuildContext context,AppStates state)
          {
            if(state is InitialAppStates) print('intial state');
          },

          builder: (BuildContext context ,AppStates state) {
            AppCubit cubit = AppCubit.get(context);
            var categorymodel=AppCubit.get(context).categoriesDataModel;


            return ConditionalBuilder(
              condition: cubit.categoriesDataModel !=null,
              fallback: (context)=>  Center(
                child: CircularProgressIndicator(),

              ),
              builder: (context) => ListView.separated(itemBuilder: ((context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: InkWell(
                  onTap: (){
                    AppCubit.get(context).getCategoriesDetails( categoryId: categorymodel.categoriesData.data[index].id);
                    NavigateTo(context: context,router:CategoryDetailsScreen(categorymodel.categoriesData.data[index].name));
                  },
                  child: Container(

                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          width: 1,
                          color:Colors.grey[300]
                      ),),
                    child:  buildCategory(categorymodel.categoriesData.data[index],context,)
                  ),

                  ),
                )
              ),
                  separatorBuilder: ((context, index) =>SizedBox.shrink()),
                  itemCount: categorymodel.categoriesData.data.length)


            );

          },
        )

    );
  }

  Widget buildCategory(Data model,BuildContext context,)=>  Row(
    children: [
      // SizedBox(width: 15,),
      Image(image: NetworkImage("${model.image}"),
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width /3,
        //height: MediaQuery.of(context).size.height / 5,

      ),
      SizedBox(width: 10,),
      Text(" ${model.name}",style: TextStyle(
        fontSize: 18,
        fontFamily: "Font1",

      ),),
      Spacer(),
      Icon(Icons.arrow_forward_ios,color: defultColor),




    ],
  );
}
