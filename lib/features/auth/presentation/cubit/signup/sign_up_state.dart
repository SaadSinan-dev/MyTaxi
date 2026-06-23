enum SignUpStatus { initial, loading, success, error }

class SignUpState {
  final SignUpStatus status;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String? errorMessage;

  const SignUpState({
    this.status = SignUpStatus.initial,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.errorMessage,
  });

  SignUpState copyWith({
    SignUpStatus? status,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? errorMessage,
  }) {
    return SignUpState(
      status: status ?? this.status,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      errorMessage: errorMessage,
    );
  }
}
