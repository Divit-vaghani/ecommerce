import 'package:ecommerce/const/const.dart';
import 'package:ecommerce/model/header.dart';
import 'package:ecommerce/model/shopping_mall.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<ShoppingMall> getProductListing() async {
    try {
      http.Response response = await http.get(
        Uri.parse(WebApiUtility.url),
        headers: Header(token: WebApiUtility.token).toJson(),
      );
      return shoppingMallFromJson(response.body);
    } catch (err) {
      return ShoppingMall.withError('$err');
    }
  }
}
