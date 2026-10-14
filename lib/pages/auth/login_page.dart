import 'package:flutter/material.dart';
import 'package:jewelry_app/core/widget/background/welcome_background.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: WelcomeBackground(
        intersectionOffset: size.height * 0.25, // ðŸ‘ˆ nÃ¢ng Ä‘iá»ƒm giao nhau lÃªn giá»¯a mÃ n
        child: Center(
          child: Text("ÄÄƒng nháº­p", style: TextStyle(fontSize: 22)),
        ),
      ),
    );
  }
}
