// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.userId,
    required this.email,
    required this.name,
    required this.phoneNo,
    required this.referCode,
    required this.usersRefCode,
    required this.profileImg,
    required this.userType,
    required this.wishlist,
    required this.tickets,
    this.otp,
    this.coins,
  });

  dynamic userId;
  dynamic email;
  dynamic name;
  dynamic phoneNo;
  dynamic referCode;
  dynamic usersRefCode;
  dynamic profileImg;
  dynamic userType;
  dynamic coins;
  List<dynamic> wishlist;
  List<dynamic> tickets;

  dynamic otp;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        email: json["email"],
        name: json["name"],
        phoneNo: json["phone_no"],
        referCode: json["refer_code"],
        usersRefCode: json["users_ref_code"],
        profileImg: json["profile_img"],
        userType: json["user_type"],
        coins: json["coins"],
        wishlist: List<dynamic>.from(json["Wishlist"].map((x) => x)),
        tickets: List<dynamic>.from(json["Tickets"].map((x) => x)),
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "name": name,
        "phone_no": phoneNo,
        "refer_code": referCode,
        "users_ref_code": usersRefCode,
        "profile_img": profileImg,
        "user_type": userType,
        "coins": coins,
        "Wishlist": List<dynamic>.from(wishlist.map((x) => x)),
        "Tickets": List<dynamic>.from(tickets.map((x) => x)),
        "otp": otp,
      };
}
