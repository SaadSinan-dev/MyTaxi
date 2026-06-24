import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_taxi/core/colors/app_colors.dart';
import 'package:my_taxi/core/spacing/app_spacing.dart';
import 'package:my_taxi/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:my_taxi/features/auth/presentation/cubit/login/login_state.dart';
import 'package:my_taxi/features/auth/presentation/validators/auth_validators.dart';
import 'package:my_taxi/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:my_taxi/features/auth/presentation/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!formKey.currentState!.validate()) return;

    context.read<LoginCubit>().login(
          phone: phoneController.text.trim(),
          password: passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          Navigator.pushReplacementNamed(context, '/home');
        }
        if (state.status == LoginStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Login failed')),
          );
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                final cubit = context.read<LoginCubit>();

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: AppSpacing.xl + AppSpacing.xs),
                        Container(
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
                        const SizedBox(height: AppSpacing.lg),
                        const Text(
                          "My Taxi",
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxl),
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
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            Checkbox(
                              value: state.rememberMe,
                              onChanged: (_) => cubit.toggleRememberMe(),
                            ),
                            const Text('Remember me'),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: state.status == LoginStatus.loading
                                ? null
                                : _submit,
                            child: state.status == LoginStatus.loading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Login'),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Row(
                          children: [
                            Expanded(
                              child: SocialButton(
                                icon: Icons.g_mobiledata,
                                label: 'Google',
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: SocialButton(
                                icon: Icons.apple,
                                label: 'Apple',
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: const Text("Create account"),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
