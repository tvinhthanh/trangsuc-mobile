import 'package:flutter/material.dart';
import 'package:jewelry_app/core/widget/background/welcome_background.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeBackground(
        child: SafeArea(
          child: Column(
            children: const [
              Spacer(),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
