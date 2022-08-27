part of 'shopping_bloc.dart';

abstract class ShoppingEvent extends Equatable {
  const ShoppingEvent();
}

class GetShoppingList extends ShoppingEvent {
  @override
  List<Object?> get props => [];
}

class GetCartList extends ShoppingEvent {
  @override
  List<Object?> get props => [];
}

class AddToCart extends ShoppingEvent {
  final Datum datum;
  const AddToCart({required this.datum});
  @override
  List<Object?> get props => [datum];
}

class RemoveFromCart extends ShoppingEvent {
  final Datum datum;
  const RemoveFromCart({required this.datum});
  @override
  List<Object?> get props => [datum];
}

class AddItem extends ShoppingEvent {
  final Datum datum;
  const AddItem({required this.datum});
  @override
  List<Object?> get props => [datum];
}

class RemoveItem extends ShoppingEvent {
  final Datum datum;
  const RemoveItem({required this.datum});
  @override
  List<Object?> get props => [datum];
}
