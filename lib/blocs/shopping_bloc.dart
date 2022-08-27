import 'package:ecommerce/database/data_base_helper.dart';
import 'package:ecommerce/model/shopping_mall.dart';
import 'package:ecommerce/webservice/web_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shopping_event.dart';
part 'shopping_state.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  ShoppingBloc() : super(ShoppingInitial()) {
    final WebApiRepository api = WebApiRepository();
    final DataBaseHelper dataBaseHelper = DataBaseHelper.instance;

    on<ShoppingEvent>((event, emit) async {
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
  }

  @override
  Future<void> close() {
    final DataBaseHelper dataBaseHelper = DataBaseHelper.instance;
    dataBaseHelper.close();
    return super.close();
  }
}
