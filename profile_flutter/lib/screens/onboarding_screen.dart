import 'package:flutter/material.dart';
import 'package:profile_flutter/widgets/custom_button.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static const String routeName = '/onboarding';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to \n flutter profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                text: 'Log in',
              ),
            ),
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, SignupScreen.routeName);
              },
              text: 'Sign Up',
            ),
          ],
        ),
      ),
    );
  }
}
