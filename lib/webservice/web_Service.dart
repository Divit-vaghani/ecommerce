import 'package:ecommerce/const/const.dart';
import 'package:http/http.dart' as http;

class WebService {
  static Future<http.Response> getProductListing() async {
    return await http.get(
      Uri.parse(WebApiUtility.url),
      headers: {"token": WebApiUtility.token},
    );
  }
}
