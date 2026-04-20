import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_taxi/core/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    
    await Future.delayed(const Duration(seconds: 2));

    setState(() => isLoading = false);

    if (!mounted) return;

    
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.black87,
                            size: 18,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),

                      // Header
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Join us and start booking your rides today',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 34),

                      // Full Name Field
                      const _InputLabel(text: 'Full Name'),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black87),
                        decoration: _buildInputDecoration(
                          hintText: 'Enter your full name',
                          icon: Icons.person_rounded,
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Name is required' : null,
                      ),

                      const SizedBox(height: 18),

                      // Phone Number Field
                      const _InputLabel(text: 'Phone Number'),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black87),
                        decoration: _buildInputDecoration(
                          hintText: 'Enter phone number',
                          icon: Icons.phone_rounded,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Phone number is required';
                          if (value.length < 8) return 'Invalid phone number';
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      // Password Field
                      const _InputLabel(text: 'Password'),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black87),
                        decoration: _buildInputDecoration(
                          hintText: 'Create password',
                          icon: Icons.lock_rounded,
                          suffixIcon: IconButton(
                            onPressed: () => setState(() => obscurePassword = !obscurePassword),
                            icon: Icon(
                              obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Password is required';
                          if (value.length < 6) return 'Minimum 6 characters';
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      // Confirm Password Field
                      const _InputLabel(text: 'Confirm Password'),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: obscureConfirmPassword,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => register(),
                        style: const TextStyle(color: Colors.black87),
                        decoration: _buildInputDecoration(
                          hintText: 'Confirm password',
                          icon: Icons.lock_rounded,
                          suffixIcon: IconButton(
                            onPressed: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
                            icon: Icon(
                              obscureConfirmPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != passwordController.text) return 'Passwords do not match';
                          return null;
                        },
                      ),

                      const SizedBox(height: 32),

                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
                                )
                              : const Text(
                                  'Sign Up',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Login Navigation
                      Center(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context), // Goes back to Login screen
                              child: const Text(
                                'Login',
                                style: TextStyle(color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for standardizing input fields
  InputDecoration _buildInputDecoration({required String hintText, required IconData icon, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      prefixIcon: Icon(icon, color: Colors.grey.shade500),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }
}


class _InputLabel extends StatelessWidget {
  final String text;
  const _InputLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black87),
    );
  }
}