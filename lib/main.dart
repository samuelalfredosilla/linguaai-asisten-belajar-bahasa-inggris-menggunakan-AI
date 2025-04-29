import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan binding siap

  // Muat environment variables SEBELUM menjalankan aplikasi
  try {
     await dotenv.load(fileName: ".env");
     print("File .env berhasil dimuat.");
  } catch (e) {
     print("Kesalahan saat memuat file .env: $e");
     // Pertimbangkan untuk menampilkan pesan error jika penting
  }

  runApp(const MyApp()); // Jalankan aplikasi
}