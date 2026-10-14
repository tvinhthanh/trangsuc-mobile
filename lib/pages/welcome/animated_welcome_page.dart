import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jewelry_app/core/widget/background/welcome_background.dart';

class AnimatedWelcomePage extends StatelessWidget {
  const AnimatedWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeBackground(
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              const SizedBox(height: 100),
              Image.asset('assets/images/logo.png', width: 120),
              const SizedBox(height: 24),
              const Text(
                'Have a nice day!',
                style: TextStyle(color: Color(0xFFE6E6E6), fontSize: 20),
              ),
              const SizedBox(height: 82),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    _roundedButton(
                      context,
                      label: 'Đăng nhập',
                      mode: 'login',
                      isWhite: false,
                    ),
                    const SizedBox(height: 16),
                    _roundedButton(
                      context,
                      label: 'Đăng ký',
                      mode: 'signup',
                      isWhite: true,
                    ),
                  ],
                ),
              ),
              Image.asset('assets/images/rings.png', height: 250),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roundedButton(BuildContext context,
      {required String label, required String mode, required bool isWhite}) {
    return GestureDetector(
      onTap: () {
        context.go('/auth?mode=$mode'); // 👈 Điều hướng qua AuthPage
      },
      child: Center(
        child: Container(
          width: 260,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: isWhite ? Colors.white : const Color(0x4CE3E3E3),
            border: isWhite ? null : Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(38),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isWhite ? const Color(0xFF745F9A) : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
