import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_app/data/model/product_model.dart';
import 'package:user_app/domain/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeEvent>((event, emit) {});
    on<HomeInitFetchEvent>(homeInitFetchEvent);
  }

  FutureOr<void> homeInitFetchEvent(
      HomeInitFetchEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingState());
      final responseBody = await HomeRepository.getFetchHomepage();

      ProductModel productModel = ProductModel.fromJson(responseBody['data']);
      emit(HomeLoadedSuccessState(productModel));
    } catch (err) {
      emit(HomeErrorState());
    }
  }
}
