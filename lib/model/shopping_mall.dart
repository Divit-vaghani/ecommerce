import 'dart:convert';

ShoppingMall shoppingMallFromJson(String str) =>
    ShoppingMall.fromJson(json.decode(str));

String shoppingMallToJson(ShoppingMall data) => json.encode(data.toJson());

class ShoppingMall {
  ShoppingMall(
      {this.status,
      this.message,
      this.totalRecord,
      this.totalPage,
      this.data,
      this.error});

  int? status;
  String? message;
  int? totalRecord;
  int? totalPage;
  List<Datum>? data;
  String? error;

  factory ShoppingMall.withError(String error) => ShoppingMall(error: error);

  factory ShoppingMall.fromJson(Map<String, dynamic> json) => ShoppingMall(
        status: json["status"],
        message: json["message"],
        totalRecord: json["totalRecord"],
        totalPage: json["totalPage"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalRecord": totalRecord,
        "totalPage": totalPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.slug,
    this.title,
    this.description,
    this.price,
    this.featuredImage,
    this.status,
    this.createdAt,
    this.cart,
  });

  int? id;
  String? slug;
  String? title;
  String? description;
  int? price;
  String? featuredImage;
  String? status;
  String? createdAt;
  int? cart;

  Datum.carts({this.cart, this.id});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        slug: json["slug"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        featuredImage: json["featured_image"],
        status: json["status"],
        createdAt: json["created_at"],
        cart: json["cart"],
      );

  Map<String, dynamic> toJsonAddCart() => {
        "id": id,
        "cart": cart,
      };

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "description": description,
        "price": price,
        "featured_image": featuredImage,
        "status": status,
        "created_at": createdAt,
        "cart": cart,
      };
}
