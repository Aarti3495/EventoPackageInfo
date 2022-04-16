import 'package:flutter/material.dart';

class Constants {
  final String apiUrl = "http://64.227.167.195:8000/";
  final String baseUrl = "";
  final double iconSize = 20;
  final String imageUrl = "http://eventopackage.com";
  static const String chatBoatUrl = 'http://64.227.167.195:8000/';
  static const String webSocketUrl =
      "ws://64.227.167.195:8000/ws/chat/festumroom/";

  static const String appToken = "apptoken";

  //STORAGE
  final String token = "accessToken";
  final String userId = "userId";
  final String userData = "userData";
  final String countryCode = "countryCode";
  final String language = "language";

  //CONSTANT MESSAGES
  final String noInternetFound = "No Internet Found!";
  static const String someThingWentWrong = "Something Went Wrong! Try Again Latter";

  //CONSTANT IMAGE PATHS
  final String noImage = "assets/images/placeholder.jpeg";

  //COLOR CONSTANTS
  final Color topBarColor = const Color(0xFF2F363F);

  //ERROR OUTPUTS
  final List errorOutputs = [
    {"status": 400, "message": "Bad Request!"},
    {"status": 401, "message": "Unauthorized Request!"},
    {"status": 403, "message": "Forbidden Request!"},
    {"status": 404, "message": "Requested Url Not Found!"},
    {"status": 413, "message": "Payload Too Large!"},
    {"status": 503, "message": "Service Unavailable!"},
    {"status": 500, "message": "Internal Server Error!"},
    {"status": 504, "message": "Gateway Timeout!"}
  ];

  //REQUEST WITH NO AUTH
  final List noAuthRequest = ['login', 'register'];
}
