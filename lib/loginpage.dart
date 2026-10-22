import 'package:flutter/material.dart';
import 'wheelpage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD15B),
      // resizeToAvoidBottomInset dikarenakan keyboard muncul agar posisi gambar tidak berantakan
      resizeToAvoidBottomInset: false, 
      body: Stack(
        children: [
          // 1. MASKOT SI BIRU (Menempel sempurna di paling bawah layar)
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/sibiru.png',
              fit: BoxFit.fitWidth, // Memenuhi lebar layar secara proporsional
              width: double.infinity,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),

          // 2. KONTEN FORM LOGIN
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Welcome Back,\nFellas!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sign in and let\'s get right back to the wheel!',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 32),
                  _buildInputField(hint: 'Username'),
                  const SizedBox(height: 16),
                  _buildInputField(hint: 'Password', isPassword: true),
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
                    child: const Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Teks bawah jika ada
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Doesn't have any account? Sign up Here!",
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ),
                  ),
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