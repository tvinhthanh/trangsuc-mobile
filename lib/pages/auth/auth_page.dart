import 'package:flutter/material.dart';
import 'package:jewelry_app/core/form/forget_pass_form.dart';
import 'package:jewelry_app/core/form/login_form.dart';
import 'package:jewelry_app/core/form/reset_pass_form.dart';
import 'package:jewelry_app/core/form/signup_form.dart';
import 'package:jewelry_app/core/widget/background/auth_background.dart';
import 'package:jewelry_app/core/widget/background/background_low.dart';


enum BackgroundLevel { low, normal, high }

class AuthPage extends StatefulWidget {
  final String mode; // 'login', 'signup', 'forgot', 'reset'

  const AuthPage({super.key, required this.mode});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late String currentMode;
  String? previousMode;

  final levelOrder = [
    BackgroundLevel.low,
    BackgroundLevel.normal,
    BackgroundLevel.high,
  ];

  @override
  void initState() {
    super.initState();
    currentMode = widget.mode;
  }

  void switchMode(String mode) {
    setState(() {
      previousMode = currentMode;
      currentMode = mode;
    });
  }

  BackgroundLevel _getBackgroundLevel(String mode) {
    switch (mode) {
      case 'login':
      case 'signup':
      case 'reset':
        // return BackgroundLevel.high;
      case 'forgot':
        return BackgroundLevel.normal;
      default:
        return BackgroundLevel.low;
    }
  }

  Widget _buildBackground({required Widget child}) {
    final oldLevel = _getBackgroundLevel(previousMode ?? currentMode);
    final newLevel = _getBackgroundLevel(currentMode);
    final isGoingUp = levelOrder.indexOf(newLevel) > levelOrder.indexOf(oldLevel);

    Widget bg;
    switch (newLevel) {
      case BackgroundLevel.high:
        bg = WelcomeBackground2(child: child);
        break;
      case BackgroundLevel.normal:
        bg = WelcomeBackground2(child: child);
        break;
      case BackgroundLevel.low:
      default:
        bg = WelcomeBackgroundLow(child: child);
        break;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: Offset(0, isGoingUp ? 1 : -1),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(position: offsetAnimation, child: child);
      },
      child: KeyedSubtree(
        key: ValueKey(newLevel),
        child: bg,
      ),
    );
  }

  Widget _buildForm() {
    switch (currentMode) {
      case 'login':
        return LoginForm(
          key: const ValueKey('login'),
          onToggle: () => switchMode('signup'),
          onForgot: () => switchMode('forgot'),
        );
      case 'signup':
        return SignUpForm(
          key: const ValueKey('signup'),
          onToggle: () => switchMode('login'),
        );
      case 'forgot':
        return ForgetForm(
          key: const ValueKey('forgot'),
          onSubmit: () => switchMode('reset'),
        );
      case 'reset':
        return ResetForm(
          key: const ValueKey('reset'),
          onSubmit: () => switchMode('login'),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBackground(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // Logo
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset('assets/images/logo.png', width: 100),
              ),
            ),
            // Ảnh nhẫn dưới
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/rings.png', height: 300),
            ),
            // Form động
            Positioned(
              top: 220,
              left: 24,
              right: 24,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: _buildForm(),
              ),
            ),

            
          ],
        ),
      ),
    );
  }
}
