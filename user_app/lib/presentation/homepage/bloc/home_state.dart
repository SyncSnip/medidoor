part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  HomeLoadedSuccessState(this.productModel);
  final ProductModel productModel;
}

class HomeErrorState extends HomeState {}
