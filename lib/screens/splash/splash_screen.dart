import 'dart:async'; // Import untuk Timer
import 'package:flutter/material.dart';
import '../home/home_screen.dart'; // Import layar tujuan

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Mulai timer saat layar ini pertama kali dibuat
    Timer(
      const Duration(seconds: 3), // Durasi splash screen (misal 3 detik)
      () {
        // Setelah durasi selesai, pindah ke HomeScreen
        // Gunakan pushReplacement agar pengguna tidak bisa kembali ke splash screen
        if (mounted) { // Cek jika widget masih terpasang
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // UI Splash Screen
    return Scaffold(
      // Background bisa disesuaikan (warna atau gambar)
      backgroundColor: Colors.deepPurple.shade50, // Contoh warna background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tampilkan Logo Anda
            Image.asset(
              'assets/images/logo.png', // <<< GANTI DENGAN PATH LOGO ANDA
              width: 150, // Sesuaikan ukuran logo
              height: 150,
            ),
            const SizedBox(height: 20),
            // Opsional: Tambahkan teks "Loading..." atau indikator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Text(
              'Memuat Asisten Bahasa...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepPurple.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}