import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'wheelpage.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4AC4E2),
      // Mencegah posisi maskot terdorong saat keyboard muncul
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 1. MASKOT SI KUNING (Menempel sempurna di paling bawah layar)
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/sikuning.png',
              fit: BoxFit.fitWidth,
              width: double.infinity,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),

          // 2. KONTEN FORM SIGN UP
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Let\'s get you in,\ncolor hacker!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Set up your profile to start scrolling and learning.',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                  const SizedBox(height: 32),
                  _buildInputField(hint: 'Username'),
                  const SizedBox(height: 14),
                  _buildInputField(hint: 'Email'),
                  const SizedBox(height: 14),
                  _buildInputField(hint: 'Password', isPassword: true),
                  const SizedBox(height: 14),
                  _buildInputField(hint: 'Confirm Password', isPassword: true),
                  const SizedBox(height: 28),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const WheelPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E1E1E),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('Sign Up',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Already have an account? Sign in',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                  // Space bawah agar konten teratas tetap bisa discroll dengan aman jika layar pendek
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({required String hint, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.85),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}