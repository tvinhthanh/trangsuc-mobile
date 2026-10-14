import 'package:flutter/material.dart';

class ResetForm extends StatefulWidget {
  final VoidCallback onSubmit;

  const ResetForm({super.key, required this.onSubmit});

  @override
  State<ResetForm> createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 140),
            const Text(
              'Đặt lại mật khẩu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            _buildInputField(hint: 'Email', controller: emailController, isPrimary: true),
            const SizedBox(height: 16),
            _buildInputField(hint: 'Mật khẩu', controller: passwordController, obscureText: true),
            const SizedBox(height: 16),
            _buildInputField(hint: 'Xác nhận mật khẩu', controller: confirmPasswordController, obscureText: true),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: widget.onSubmit,
              child: _roundedButton(label: 'Đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String hint,
    required TextEditingController controller,
    bool isPrimary = false,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF1F3FF),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: isPrimary ? const Color(0xFF3D5CFF) : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _roundedButton({required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF4D70CC),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
