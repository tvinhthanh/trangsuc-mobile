import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onToggle;
  final VoidCallback onForgot; // 👈 Thêm callback này

  const LoginForm({
    super.key,
    required this.onToggle,
    required this.onForgot,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 124),
            const Text(
              'Đăng nhập',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            _buildInputField(hint: 'Email', isPrimary: true),
            const SizedBox(height: 16),
            _buildInputField(hint: 'Password'),
            const SizedBox(height: 16),

            // Ghi nhớ đăng nhập
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: rememberMe,
                    activeColor: const Color(0xFF4D70CC),
                    onChanged: (val) => setState(() => rememberMe = val ?? false),
                  ),
                  const Text('Ghi nhớ đăng nhập'),
                ],
              ),
            ),

            // Quên mật khẩu
            Center(
              child: TextButton(
                onPressed: widget.onForgot, // 👈 Gọi callback
                child: const Text(
                  'Bạn quên mật khẩu?',
                  style: TextStyle(color: Color(0xFF4D70CC)),
                ),
              ),
            ),

            const SizedBox(height: 4),

            // 2 nút Đăng nhập & Vân tay
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => context.go('/home'),
                  child: _roundedButton(label: 'Đăng nhập', icon: null),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: xử lý đăng nhập vân tay ở đây
                    debugPrint("Fingerprint pressed");
                  },
                  child: _roundedButton(label: 'Vân tay', icon: Icons.fingerprint),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Chuyển sang đăng ký
            TextButton(
              onPressed: widget.onToggle,
              child: const Text('Chưa có tài khoản? Đăng ký'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required String hint, bool isPrimary = false}) {
    return TextField(
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

  Widget _roundedButton({required String label, IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
