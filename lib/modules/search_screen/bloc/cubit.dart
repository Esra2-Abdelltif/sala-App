import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaa_app/models/secrch_model/SearchModel.dart';
import 'package:salaa_app/modules/search_screen/bloc/states.dart';

import '../../../shared/Constans/constans.dart';
import '../../../shared/Network/end_point/end_point.dart';
import '../../../shared/Network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void SearchProduct(String text){
    emit(SearchLoadingStates());
    DioHelper.postData(
      Url: SEARCH,
      data: {
        "text": text
        } ,
        token: token
    ).then((value){
     model =SearchModel.fromJson(value.data);
      emit(SearchSuccessStates());
    }).catchError((error){
      emit(SearchErrorStates(error));
    });

  }

}