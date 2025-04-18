class Endpoints {
  static const String login = "/login_with_email";
  static const String login_with_phoneNumber = "/login_with_phone";
  static const String resend_login_OTP = "/resend_login_OTP";
  static const String resend_requestPasswordReset_OTP = "/resend_request_password_reset_mobile_app";
  static const String register = "/register_with_email";
  static const String find_by_email = "/find_by_email";
  static const String find_by_phone = "/find_by_phone";
  static const String logout = "/logout";
  static const String verifyOTP = "/verify_otp_for_password_reset";
  static const String verifyLoginOTPPhoneNumber = "/verify_login_OTP";
  static const String resendVerifyLoginOTPPhoneNumber = "/verify_login_OTP";
  static const String phoneNumberVerifyOTP = "/verify_otp_for_password_reset";
  static const String verifyOTPRegister = "/verify_OTP";
  static const String RequestUpdatePassword = "/request_password_reset_mobile_app";
  static const String createNewPassword = "/reset_password";
  static const String updatePassword = "/request_password_reset_mob";
  static const String changepassword = "/password_update";
  static const String updateProfil = "/update_info";
  static const String userDetails = "/profile";
  static const String sendOTP = "/api/auth/send-otp";
}