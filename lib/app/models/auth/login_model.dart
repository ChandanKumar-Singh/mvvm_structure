class SocialLoginModel {
  String? email;
  String? password;
  String? name;
  String? phone;
  String? image;
  String? provider;
  String? providerId;
  String? token;
  String? fcmToken;
  String? deviceType;
  String? deviceToken;
  String? deviceName;
  String? deviceOs;
  String? deviceOsVersion;
  String? deviceModel;
  SocialLoginType socialLoginType;

  SocialLoginModel(
      {this.email,
      this.password,
      this.name,
      this.phone,
      this.image,
      this.provider,
      this.providerId,
      this.token,
      this.fcmToken,
      this.deviceType,
      this.deviceToken,
      this.deviceName,
      this.deviceOs,
      this.deviceOsVersion,
      this.deviceModel,
      this.socialLoginType = SocialLoginType.none});
}

enum SocialLoginType {
  google,
  facebook,
  apple,
  twitter,
  github,
  phone,
  email,
  password,
  none
}
