import 'package:flutter/material.dart';
import '../../services/gemini_service.dart';
import 'widgets/feature_card.dart';
import 'widgets/practice_card.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GeminiService _geminiService = GeminiService();
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _sentenceController = TextEditingController();
  String _exampleSentencesResult = ""; String _sentenceCheckResult = ""; String _practicePromptResult = "";
  bool _isLoadingExamples = false; bool _isLoadingCheck = false; bool _isLoadingPractice = false;
  final String _targetLanguage = "Bahasa Inggris";
  final bool _isApiKeySet = dotenv.env['GEMINI_API_KEY'] != null && dotenv.env['GEMINI_API_KEY']!.isNotEmpty && dotenv.env['GEMINI_API_KEY'] != 'API_KEY_ANDA_YANG_BARU_DAN_AMAN'; // Update placeholder check jika perlu

  // --- Logika Fitur ---
  Future<void> _getExampleSentences() async { /* ... (sama seperti sebelumnya) ... */ if (!_validateApiKey()) return; final String input = _wordController.text.trim(); if (input.isEmpty) { setState(() => _exampleSentencesResult = "Error: Masukkan kata atau frasa."); return; } setState(() { _isLoadingExamples = true; _exampleSentencesResult = ""; }); final prompt = "Berikan 3 contoh kalimat sederhana dalam $_targetLanguage menggunakan kata atau frasa '$input'. Buat kalimat yang natural dan cocok untuk pelajar pemula."; final result = await _geminiService.generateContent(prompt); if (mounted) { setState(() { _exampleSentencesResult = result; _isLoadingExamples = false; }); } }
  Future<void> _checkSentence() async { /* ... (sama seperti sebelumnya) ... */ if (!_validateApiKey()) return; final String input = _sentenceController.text.trim(); if (input.isEmpty) { setState(() => _sentenceCheckResult = "Error: Masukkan kalimat Anda."); return; } setState(() { _isLoadingCheck = true; _sentenceCheckResult = ""; }); final prompt = "Periksa tata bahasa dasar pada kalimat $_targetLanguage ini: '$input'. Fokus pada kesalahan umum pemula. Jika ada kesalahan, berikan koreksi singkat dan jelaskan kesalahannya dalam Bahasa Indonesia dengan sederhana (misal: 'Kata kerja seharusnya...'). Jika kalimat sudah benar atau cukup baik, katakan 'Kalimat terlihat bagus!'."; final result = await _geminiService.generateContent(prompt); if (mounted) { setState(() { _sentenceCheckResult = result; _isLoadingCheck = false; }); } }
  Future<void> _generatePracticePrompt() async { /* ... (sama seperti sebelumnya) ... */ if (!_validateApiKey()) return; setState(() { _isLoadingPractice = true; _practicePromptResult = ""; }); final prompt = "Buatkan satu tugas latihan singkat dan bervariasi untuk pelajar $_targetLanguage tingkat pemula-menengah. Contoh variasi: Terjemahkan kalimat pendek B.Indonesia ke $_targetLanguage, ATAU jawab pertanyaan sederhana dalam $_targetLanguage, ATAU buat kalimat menggunakan kata $_targetLanguage yang diberikan. Berikan HANYA instruksi tugasnya dengan jelas."; final result = await _geminiService.generateContent(prompt); if (mounted) { setState(() { _practicePromptResult = result; _isLoadingPractice = false; }); } }
  bool _validateApiKey() { /* ... (sama seperti sebelumnya) ... */ if (!_isApiKeySet) { setState(() { _exampleSentencesResult = "Error: API Key Gemini belum diatur di file .env!"; _sentenceCheckResult = "Error: API Key Gemini belum diatur di file .env!"; _practicePromptResult = "Error: API Key Gemini belum diatur di file .env!"; }); ScaffoldMessenger.of(context).showSnackBar( const SnackBar( content: Text('API Key belum diatur! Periksa file .env'), backgroundColor: Colors.red, ), ); return false; } return true; }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Asisten Belajar $_targetLanguage'), backgroundColor: Theme.of(context).colorScheme.primaryContainer, // Ganti warna AppBar jika mau
      ),
      body: GestureDetector( onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView( padding: const EdgeInsets.all(16.0),
          child: Column( crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (!_isApiKeySet) Container( /* ... (Widget Peringatan API Key sama seperti sebelumnya) ... */ padding: const EdgeInsets.all(12), margin: const EdgeInsets.only(bottom: 16), decoration: BoxDecoration( color: Colors.orange.shade100, border: Border.all(color: Colors.orange.shade300), borderRadius: BorderRadius.circular(8) ), child: Row( children: [ Icon(Icons.warning_amber_rounded, color: Colors.orange.shade800), const SizedBox(width: 10), Expanded( child: Text( "Peringatan: API Key Gemini belum diatur di file .env. Fitur AI tidak akan berfungsi.", style: TextStyle(color: Colors.orange.shade900, fontWeight: FontWeight.w500), ), ), ], ), ),
              FeatureCard( title: "Contoh Penggunaan Kata/Frasa", inputController: _wordController, inputHint: "Masukkan kata/frasa (misal: 'learn')", buttonText: "Dapatkan Contoh", onPressed: _getExampleSentences, isLoading: _isLoadingExamples, result: _exampleSentencesResult, ),
              FeatureCard( title: "Periksa Kalimat Saya", inputController: _sentenceController, inputHint: "Tulis kalimat Anda di sini...", buttonText: "Periksa Tata Bahasa", onPressed: _checkSentence, isLoading: _isLoadingCheck, result: _sentenceCheckResult, isMultiLineInput: true, ),
              PracticeCard( title: "Latihan Cepat", onPressed: _generatePracticePrompt, isLoading: _isLoadingPractice, result: _practicePromptResult, ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() { _wordController.dispose(); _sentenceController.dispose(); super.dispose(); }
}