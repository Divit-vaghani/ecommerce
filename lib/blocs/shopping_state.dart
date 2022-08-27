part of 'shopping_bloc.dart';

abstract class ShoppingState extends Equatable {
  const ShoppingState();
}

class ShoppingInitial extends ShoppingState {
  @override
  List<Object?> get props => [];
}

class ShoppingLoading extends ShoppingState {
  @override
  List<Object?> get props => [];
}

class ShoppingLoaded extends ShoppingState {
  final List<Datum> products;

  const ShoppingLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class ShoppingError extends ShoppingState {
  final String? message;

  const ShoppingError({this.message});

  @override
  List<Object?> get props => [message];
}

class CartLoading extends ShoppingState {
  @override
  List<Object?> get props => [];
}

class CartLoaded extends ShoppingState {
  final List<Datum> products;
  final int totalItems;
  final int totalPrice;

  const CartLoaded({
    required this.products,
    required this.totalItems,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [products, totalPrice, totalItems];
}

class CartEmpty extends ShoppingState {
  @override
  List<Object?> get props => [];
}
