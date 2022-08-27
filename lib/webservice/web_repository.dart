import 'package:ecommerce/model/shopping_mall.dart';
import 'package:ecommerce/webservice/web_service.dart';

class WebApiRepository {
  final WebService _webService = WebService();
  Future<ShoppingMall> fetchProductListing() => _webService.getProductListing();
}

class UnknownNetworkError extends Error {}
