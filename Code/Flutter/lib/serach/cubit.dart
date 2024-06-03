
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/serach/state.dart';

import '../core/ModelSearch.dart';
import '../core/ModelSearchTow.dart';
import '../core/dio_helper.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  String? selectedDataBase;


  void selectSubService(String dataBaseName) {
    selectedDataBase = dataBaseName;
    emit(SelectDataBase(dataBaseName));
  }


  ModelSearch modelSearch=ModelSearch();
  postAntique({required query}) {
    emit(PostAntiqueLoadingState());
    DioHelper.postData(url: 'antique/search', data: { "query": query})
        .then((value) {
      modelSearch = ModelSearch.fromJson(value.data);
      print(value.data.toString());
      emit(PostAntiqueSuccessState());
    }).catchError((error) {
      print(error);
      emit(PostAntiqueErrorState());
    });
  }

  ModelSearch modelSearchLotte=ModelSearch();
  postLotte({required query}) {
    emit(PostAntiqueLoadingState());
    DioHelper.postData(url: 'lotte/search', data: { "query": query})
        .then((value) {
      modelSearchLotte = ModelSearch.fromJson(value.data);
      print(value.data.toString());
      emit(PostAntiqueSuccessState());
    }).catchError((error) {
      print(error);
      emit(PostAntiqueErrorState());
    });
  }

  ModelSearchTow modelSearchTow=ModelSearchTow();
  postOnSearchAntique({required query}) {
    emit(PostAntiqueLoadingState());
    DioHelper.postData(url: 'antique/query/predict', data: { "query": query})
        .then((value) {
      modelSearchTow = ModelSearchTow.fromJson(value.data);
      print(value.data.toString());
      emit(PostAntiqueSuccessState());
    }).catchError((error) {
      print(error);
      emit(PostAntiqueErrorState());
    });
  }

  ModelSearchTow modelSearchTowLotte=ModelSearchTow();
  postOnSearchLotte({required query}) {
    emit(PostAntiqueLoadingState());
    DioHelper.postData(url: 'lotte/query/predict', data: { "query": query})
        .then((value) {
      modelSearchTowLotte = ModelSearchTow.fromJson(value.data);
      print(value.data.toString());
      emit(PostAntiqueSuccessState());
    }).catchError((error) {
      print(error);
      emit(PostAntiqueErrorState());
    });
  }

}