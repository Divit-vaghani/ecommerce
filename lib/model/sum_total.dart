import 'dart:convert';

List<SumPrice> sumPriceFromJson(String str) =>
    List<SumPrice>.from(json.decode(str).map((x) => SumPrice.fromJson(x)));

String sumPriceToJson(List<SumPrice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SumPrice {
  SumPrice({
    this.sumPriceStatus,
  });

  int? sumPriceStatus;

  factory SumPrice.fromJson(Map<String, dynamic> json) => SumPrice(
        sumPriceStatus: json["SUM(price*status)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(price*status)": sumPriceStatus,
      };
}
