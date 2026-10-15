import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'signuppage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5CC091),
      body: Stack(
        children: [
          // 1. MASKOT SI MERAH (Posisi Paling Bawah)
          Positioned(
            bottom: -20, // Menggeser sedikit ke bawah agar tampak seperti 'mengintip' dari bawah layar
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/simerah.png', // Pastikan nama & path file sesuai di pubspec.yaml
              height: 220, // Adjust tinggi maskot sesuai selera
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const SizedBox(), // Tampilan kosong jika aset belum ada
            ),
          ),

          // 2. KONTEN UTAMA (Teks & Tombol)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Let's Scroll to fuel\nyour Dopamine!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Tombol Login
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFAB914),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Tombol Sign Up
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF1F1F1),
                      foregroundColor: Colors.black87,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  
                  // Ruang jarak bawah agar tombol tidak bertabrakan dengan maskot
                  const SizedBox(height: 180),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}