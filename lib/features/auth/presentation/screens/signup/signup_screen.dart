import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_taxi/core/colors/app_colors.dart';
import 'package:my_taxi/core/spacing/app_spacing.dart';
import 'package:my_taxi/features/auth/presentation/cubit/signup/sign_up_cubit.dart';
import 'package:my_taxi/features/auth/presentation/cubit/signup/sign_up_state.dart';
import 'package:my_taxi/features/auth/presentation/validators/auth_validators.dart';
import 'package:my_taxi/features/auth/presentation/widgets/auth_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!formKey.currentState!.validate()) return;

    context.read<SignUpCubit>().register(
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
          password: passwordController.text.trim(),
          confirmPassword: confirmPasswordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.success) {
          Navigator.pushReplacementNamed(context, '/home');
        }

        if (state.status == SignUpStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Something went wrong'),
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.sm),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios_new),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Center(
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.local_taxi_rounded,
                            color: Colors.white,
                            size: 100,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const Center(
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AuthTextField(
                        controller: nameController,
                        hintText: 'Full name',
                        icon: Icons.person_rounded,
                        validator: AuthValidators.name,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AuthTextField(
                        controller: phoneController,
                        hintText: 'Phone number',
                        icon: Icons.phone_rounded,
                        keyboardType: TextInputType.phone,
                        validator: AuthValidators.phone,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AuthTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        icon: Icons.lock_rounded,
                        obscureText: state.obscurePassword,
                        validator: AuthValidators.password,
                        suffixIcon: IconButton(
                          onPressed: cubit.togglePasswordVisibility,
                          icon: Icon(
                            state.obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AuthTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm password',
                        icon: Icons.lock_rounded,
                        obscureText: state.obscureConfirmPassword,
                        validator: (value) => AuthValidators.confirmPassword(
                          value,
                          passwordController.text,
                        ),
                        suffixIcon: IconButton(
                          onPressed: cubit.toggleConfirmPasswordVisibility,
                          icon: Icon(
                            state.obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: state.status == SignUpStatus.loading
                              ? null
                              : _submit,
                          child: state.status == SignUpStatus.loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('Sign Up'),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have account?'),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
