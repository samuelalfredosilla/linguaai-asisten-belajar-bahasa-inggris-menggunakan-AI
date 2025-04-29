import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  final String? _apiKey = dotenv.env['GEMINI_API_KEY'];
  final String _baseUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent"; // Ganti model jika perlu

  Future<String> generateContent(String prompt) async {
    if (_apiKey == null || _apiKey!.isEmpty) {
      print("Kesalahan: GEMINI_API_KEY tidak ditemukan atau kosong di file .env.");
      return "Error: Konfigurasi API tidak valid. Pastikan file .env sudah benar.";
    }
    final String apiUrl = "$_baseUrl?key=$_apiKey";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [ {"parts": [ {"text": prompt} ]} ],
          // Optional: "generationConfig": { ... }, "safetySettings": [ ... ]
        }),
      ).timeout(const Duration(seconds: 60));
      return _handleResponse(response);
    } catch (e) {
      print("Terjadi kesalahan saat memanggil API: $e");
       if (e is FormatException) { return "Error: Gagal memproses respons dari server (Format tidak valid)."; }
       else if (e.toString().contains('TimeoutException')) { return "Error: Waktu permintaan habis. Coba lagi nanti."; }
       return "Error: Tidak dapat terhubung ke server ($e). Periksa koneksi internet.";
    }
  }

  String _handleResponse(http.Response response) {
     if (response.statusCode == 200) {
      try {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse.containsKey('candidates') && decodedResponse['candidates'] is List && decodedResponse['candidates'].isNotEmpty && decodedResponse['candidates'][0]['content']?['parts'] is List && decodedResponse['candidates'][0]['content']['parts'].isNotEmpty && decodedResponse['candidates'][0]['content']['parts'][0]['text'] != null) {
          return decodedResponse['candidates'][0]['content']['parts'][0]['text'].trim();
        } else if (decodedResponse.containsKey('promptFeedback') && decodedResponse['promptFeedback'].containsKey('blockReason')) {
           final reason = decodedResponse['promptFeedback']['blockReason'];
           print("Permintaan diblokir oleh filter keamanan. Alasan: $reason");
           return "Error: Permintaan diblokir (Alasan: $reason). Coba prompt yang berbeda.";
        } else if (decodedResponse.containsKey('candidates') && decodedResponse['candidates'].isEmpty) {
           print("API merespons tanpa kandidat teks.");
           return "Info: API tidak menghasilkan teks untuk prompt ini.";
        } else {
          print("Struktur respons API tidak valid: ${response.body}");
          return "Error: Menerima respons dari API, tetapi formatnya tidak dikenali.";
        }
      } catch (e) {
        print("Error parsing JSON: $e \nResponse Body: ${response.body}");
        return "Error: Gagal memproses data respons dari server.";
      }
    } else {
      String errorMessage = "Gagal menghubungi API"; String responseBody = response.body;
      try { final errorJson = jsonDecode(responseBody); if (errorJson['error']?['message'] != null) { errorMessage = errorJson['error']['message']; } }
      catch (_) { errorMessage = responseBody.isNotEmpty ? responseBody : errorMessage; }
      print("Error API: Status ${response.statusCode} - Pesan: $errorMessage");
      return "Error: Gagal menghubungi API (Status ${response.statusCode}). $errorMessage";
    }
  }
}