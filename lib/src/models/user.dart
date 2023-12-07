class LoginUser {
  String? user_id;
  String? oauth_id;
  String? vender;
  String? refresh_token;
  LoginUser({
    this.user_id,
    this.oauth_id,
    this.vender,
    this.refresh_token,
  });
  LoginUser.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    oauth_id = json['oauth_id'];
    vender = json['vender'];
    refresh_token = json['refresh_token'] == null ? '' : json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['oauth_id'] = this.oauth_id;
    data['vender'] = this.vender;
    data['refresh_token'] = this.refresh_token;

    return data;
  }
}

class UserToken {
  String? accessToken;
  String? refreshToken;

  UserToken({this.accessToken, this.refreshToken});

  UserToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}

