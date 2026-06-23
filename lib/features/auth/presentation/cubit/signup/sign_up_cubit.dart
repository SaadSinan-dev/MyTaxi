import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_taxi/features/auth/presentation/cubit/signup/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  void togglePasswordVisibility() {
    emit(
      state.copyWith(
        obscurePassword: !state.obscurePassword,
      ),
    );
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(
        obscureConfirmPassword: !state.obscureConfirmPassword,
      ),
    );
  }

  Future<void> register({
    required String name,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(status: SignUpStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(status: SignUpStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: SignUpStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
