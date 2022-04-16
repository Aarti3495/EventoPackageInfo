import 'dart:convert';

OutputHandler outputHandlerFromJson(String str) =>
    OutputHandler.fromJson(json.decode(str));

String outputHandlerToJson(OutputHandler data) => json.encode(data.toJson());

class OutputHandler {
  OutputHandler({
    required this.message,
    required this.isSuccess,
    required this.data,
    required this.status,
  });

  String message;
  bool isSuccess;
  int status;
  dynamic data;

  factory OutputHandler.fromJson(Map<String, dynamic> json) => OutputHandler(
        message: json["message"] as String,
        isSuccess: json["isSuccess"] as bool,
        data: json["data"] as String,
        status: json["status"] as int,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
        "data": data,
        "status": status
      };
}
