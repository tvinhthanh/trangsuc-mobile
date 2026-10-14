import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  final VoidCallback onToggle;

  const SignUpForm({super.key, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Tạo tài khoản',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            _buildTextField(hint: 'Email'),
            const SizedBox(height: 16),
            _buildTextField(hint: 'Mật khẩu', obscureText: true),
            const SizedBox(height: 16),
            _buildTextField(hint: 'Xác nhận mật khẩu', obscureText: true),
            const SizedBox(height: 32),
            _buildButton(),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                print("Tapped onToggle from SignUpForm");
                onToggle();
              },
              child: const Text(
                "Đăng nhập",
                style: TextStyle(
                  color: Color(0xFF3D5CFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF1F3FF),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF3D5CFF), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      ),
    );
  }

  Widget _buildButton() {
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
          )
        ],
      ),
      child: const Text(
        'Đăng ký',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }
}