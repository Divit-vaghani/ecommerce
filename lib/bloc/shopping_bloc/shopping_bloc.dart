import 'package:ecommerce/database/data_base_helper.dart';
import 'package:ecommerce/model/shopping_mall.dart';
import 'package:ecommerce/model/sum_total.dart';
import 'package:ecommerce/webservice/web_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shopping_event.dart';
part 'shopping_state.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  ShoppingBloc() : super(ShoppingInitial()) {
    final WebApiRepository api = WebApiRepository();
    final DataBaseHelper dataBaseHelper = DataBaseHelper.instance;

    on<GetShoppingList>((event, emit) async {
      try {
        emit(ShoppingLoading());
        if (await dataBaseHelper.isDataBaseExist()) {
          List<Datum> products = await dataBaseHelper.queryAll();
          emit(ShoppingLoaded(products: products));
        } else {
          final ShoppingMall shoppingMall = await api.fetchProductListing();
          if (shoppingMall.error != null) {
            emit(ShoppingError(message: shoppingMall.error));
          }
          if (shoppingMall.data != null) {
            emit(ShoppingLoaded(products: shoppingMall.data!));
          }

          if (shoppingMall.error == null) {
            for (Datum single in shoppingMall.data!) {
              await dataBaseHelper.insert(single);
            }
          }
        }
      } on UnknownNetworkError {
        emit(const ShoppingError(message: 'Unknown Error'));
      }
    });

    on<AddToCart>((event, emit) async {
      await dataBaseHelper.addToCart(event.datum);
      List<Datum> products = await dataBaseHelper.queryAll();
      emit(ShoppingLoaded(products: products));
    });

    on<RemoveFromCart>((event, emit) async {
      await dataBaseHelper.addToCart(event.datum);
      List<Datum> products = await dataBaseHelper.queryAll();
      emit(ShoppingLoaded(products: products));
    });

    on<AddItem>((event, emit) async {
      await dataBaseHelper.addRemoveItem(event.datum);
      List<Datum> products = await dataBaseHelper.getCartItems();
      List<SumPrice> totalPrice = await dataBaseHelper.getTotalRate();
      emit(CartLoaded(
        products: products,
        totalItems: products.length,
        totalPrice: totalPrice[0].sumPriceStatus ?? 0,
      ));
    });

    on<RemoveItem>((event, emit) async {
      await dataBaseHelper.addRemoveItem(event.datum);
      List<Datum> products = await dataBaseHelper.getCartItems();
      List<SumPrice> totalPrice = await dataBaseHelper.getTotalRate();
      emit(CartLoaded(
        products: products,
        totalItems: products.length,
        totalPrice: totalPrice[0].sumPriceStatus ?? 0,
      ));
    });

    on<GetCartList>((event, emit) async {
      emit(CartLoading());

      if (await dataBaseHelper.isDataBaseExist()) {
        List<Datum> products = await dataBaseHelper.getCartItems();
        List<SumPrice> totalPrice = await dataBaseHelper.getTotalRate();
        emit(CartLoaded(
          products: products,
          totalItems: products.length,
          totalPrice: totalPrice[0].sumPriceStatus ?? 0,
        ));

        if (products.isEmpty) {
          emit(CartEmpty());
        }
      } else {
        emit(CartEmpty());
      }
    });
  }

  @override
  Future<void> close() async {
    final DataBaseHelper dataBaseHelper = DataBaseHelper.instance;
    await dataBaseHelper.close();
    return super.close();
  }
}
