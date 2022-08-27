import 'package:ecommerce/model/shopping_mall.dart';
import 'package:ecommerce/webservice/web_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shopping_event.dart';
part 'shopping_state.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  ShoppingBloc() : super(ShoppingInitial()) {
    final WebApiRepository api = WebApiRepository();

    on<ShoppingEvent>((event, emit) async {
      try {
        emit(ShoppingLoading());
        final ShoppingMall shoppingMall = await api.fetchProductListing();
        emit(ShoppingLoaded(shoppingMall: shoppingMall));
        if (shoppingMall.error != null) {
          emit(ShoppingError(message: shoppingMall.error));
        }
      } on OnNetworkError {
        emit(const ShoppingError(message: 'There is Issue With Your Network'));
      }
    });
  }
}
