class UserResponse {
  bool? success;
  String? message;
  int? code;
  User? user;
  String? token;
  ExtraData? extraData;

  UserResponse({
    this.success,
    this.message,
    this.code,
    this.user,
    this.token,
    this.extraData,
  });
  UserResponse.withError(error) {
    success = false;
    message = error.toString();
  }
  UserResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'];
    code = json['code'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    extraData = json['data'] != null ? ExtraData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    data['code'] = code;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    data['token'] = token;
    if (extraData != null) {
      data['data'] = extraData?.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? avatar;
  String? status;
  String? dob;
  String? gender;
  String? userType;
  String? createdAt;
  String? updatedAt;
  var resetToken;
  String? gravatar;
  String? trimName;
  bool? isAdmin;

  User(
      {this.id,
      this.name,
      this.email,
      this.avatar,
      this.status,
      this.dob,
      this.gender,
      this.userType,
      this.createdAt,
      this.updatedAt,
      this.resetToken,
      this.gravatar,
      this.trimName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    status = json['status'];
    dob = json['dob'];
    gender = json['gender'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    resetToken = json['reset_token'];
    gravatar = json['gravatar'];
    trimName = json['trim_name'];
    isAdmin = (json['is_admin'] == null
        ? false
        : json['is_admin'] == 1
            ? true
            : false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['avatar'] = avatar;
    data['status'] = status;
    data['dob'] = dob;
    data['gender'] = gender;
    data['user_type'] = userType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['reset_token'] = resetToken;
    data['gravatar'] = gravatar;
    data['trim_name'] = trimName;
    data['is_admin'] = isAdmin;
    return data;
  }
}

class ExtraData {
  List<CurrentRequests> currentRequests = [];

  ExtraData.fromJson(Map<String, dynamic> json) {
    if (json['current_requests'] != null) {
      currentRequests = [];
      json['current_requests'].forEach((v) {
        currentRequests.add(CurrentRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (currentRequests != null) {
      data['current_requests'] =
          currentRequests.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrentRequests {
  String? name;
  String? status;
  String? createdAt;

  CurrentRequests({this.name, this.status, this.createdAt});

  CurrentRequests.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
