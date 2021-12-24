import 'dart:convert';

LoginDataModel loginDataModelFromJson(String str) =>
    LoginDataModel.fromJson(json.decode(str));

String loginDataModelToJson(LoginDataModel data) => json.encode(data.toJson());

class LoginDataModel {
  LoginDataModel({
    this.status = '',
    this.message = '',
    this.data,
  });

  String status;
  String message;
  AkunData? data;

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? AkunData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class AkunData {
  AkunData({
    this.userId,
    this.userEmail,
    this.userFirstName,
    this.userNoWa,
    this.userAvatar,
  });

  String? userId;
  String? userEmail;
  String? userFirstName;
  String? userNoWa;
  String? userAvatar;

  factory AkunData.fromJson(Map<String, dynamic> json) => AkunData(
        userId: json["user_id"],
        userEmail: json["user_email"],
        userFirstName: json["user_first_name"],
        userNoWa: json["user_no_wa"],
        userAvatar: json["user_avatar"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_email": userEmail,
        "user_first_name": userFirstName,
        "user_no_wa": userNoWa,
        "user_avatar": userAvatar,
      };
}
