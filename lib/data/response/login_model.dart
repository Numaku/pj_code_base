class LoginModel {
  LoginModel({
      this.accessToken, 
      this.userId, 
      this.firstName, 
      this.lastName, 
      this.languageId, 
      this.email, 
      this.phone, 
      this.avatar, 
      this.expiresAt,});

  LoginModel.fromJson(dynamic json) {
    accessToken = json['access_token'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    languageId = json['language_id'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    expiresAt = json['expires_at'];
  }
  String? accessToken;
  int? userId;
  String? firstName;
  String? lastName;
  int? languageId;
  String? email;
  dynamic phone;
  String? avatar;
  String? expiresAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['user_id'] = userId;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['language_id'] = languageId;
    map['email'] = email;
    map['phone'] = phone;
    map['avatar'] = avatar;
    map['expires_at'] = expiresAt;
    return map;
  }

}