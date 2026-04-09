abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}
class LoginSuccess extends AuthState {}
class LoginFailure extends AuthState {
  final String message;
  LoginFailure(this.message);
}
class RefreshTokenLoading extends AuthState {}
class RefreshTokenSuccess extends AuthState {}
class RefreshTokenFailure extends AuthState {
  final String message;
  RefreshTokenFailure(this.message);
}

class LogoutLoading extends AuthState {}
class LogoutSuccess extends AuthState {}
class LogoutFailure extends AuthState {
  final String message;
  LogoutFailure(this.message);
}

class ActivateAccountLoading extends AuthState {}
class ActivateAccountSuccess extends AuthState {}
class ActivateAccountFailure extends AuthState {
  final String message;
  ActivateAccountFailure(this.message);
}

class CreateStudentLoading extends AuthState {}
class CreateStudentSuccess extends AuthState {}
class CreateStudentFailure extends AuthState {
  final String message;
  CreateStudentFailure(this.message);
}
class ForgotPasswordLoading extends AuthState {}
class ForgotPasswordSuccess extends AuthState {}
class ForgotPasswordFailure extends AuthState {
  final String message;
  ForgotPasswordFailure(this.message);
}

class ResendOtpLoading extends AuthState {}
class ResendOtpSuccess extends AuthState {}
class ResendOtpFailure extends AuthState {
  final String message;
  ResendOtpFailure(this.message);
}

class VerifyOtpLoading extends AuthState {}
class VerifyOtpSuccess extends AuthState {}
class VerifyOtpFailure extends AuthState {
  final String message;
  VerifyOtpFailure(this.message);
}

class ResetPasswordWithTokenLoading extends AuthState {}
class ResetPasswordWithTokenSuccess extends AuthState {}
class ResetPasswordWithTokenFailure extends AuthState {
  final String message;
  ResetPasswordWithTokenFailure(this.message);
}