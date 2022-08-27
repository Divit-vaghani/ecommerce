part of 'shopping_bloc.dart';

abstract class ShoppingEvent extends Equatable {
  const ShoppingEvent();
  @override
  List<Object?> get props => [];
}

class GetShoppingList extends ShoppingEvent {}

class AddProduct extends ShoppingEvent {}
