import 'dart:convert';

Header headerFromJson(String str) => Header.fromJson(json.decode(str));

String headerToJson(Header data) => json.encode(data.toJson());

class Header {
  Header({
    required this.token,
  });

  final String token;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        token: json["token"],
      );

  Map<String, String> toJson() => {
        "token": token,
      };
}
