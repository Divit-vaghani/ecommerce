part of 'shopping_bloc.dart';

abstract class ShoppingState extends Equatable {
  const ShoppingState();

  @override
  List<Object> get props => [];
}

class ShoppingInitial extends ShoppingState {}

class ShoppingLoading extends ShoppingState {}

class ShoppingLoaded extends ShoppingState {
  final List<Datum> products;

  const ShoppingLoaded({required this.products});
}

class ShoppingError extends ShoppingState {
  final String? message;

  const ShoppingError({this.message});
}
