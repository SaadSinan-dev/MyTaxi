import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void togglePasswordVisibility() {
    emit(
      state.copyWith(
        obscurePassword: !state.obscurePassword,
      ),
    );
  }

  void toggleRememberMe() {
    emit(
      state.copyWith(
        rememberMe: !state.rememberMe,
      ),
    );
  }

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    emit(
      state.copyWith(
        status: LoginStatus.loading,
        errorMessage: null,
      ),
    );

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(
        state.copyWith(
          status: LoginStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
