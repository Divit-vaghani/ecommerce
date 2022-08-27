part of 'shopping_bloc.dart';

abstract class ShoppingState extends Equatable {
  const ShoppingState();

  @override
  List<Object> get props => [];
}

class ShoppingInitial extends ShoppingState {}

class ShoppingLoading extends ShoppingState {}

class ShoppingLoaded extends ShoppingState {
  final ShoppingMall shoppingMall;

  const ShoppingLoaded({required this.shoppingMall});
}

class ShoppingError extends ShoppingState {
  final String? message;

  const ShoppingError({this.message});
}
