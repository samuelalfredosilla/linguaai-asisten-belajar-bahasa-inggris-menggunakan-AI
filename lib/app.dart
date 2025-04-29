import 'package:flutter/material.dart';
// import 'screens/home/home_screen.dart'; // Tidak perlu import HomeScreen lagi di sini
import 'screens/splash/splash_screen.dart'; // <<< Import Splash Screen

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asisten Belajar Bahasa AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed( seedColor: Colors.deepPurple, brightness: Brightness.light,),
        useMaterial3: true,
        appBarTheme: AppBarTheme( backgroundColor: Colors.deepPurple.shade100, elevation: 1,),
        inputDecorationTheme: InputDecorationTheme( filled: true, fillColor: Colors.grey.shade100, border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none, ), focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: Theme.of(context).colorScheme.primary), ), ),
        elevatedButtonTheme: ElevatedButtonThemeData( style: ElevatedButton.styleFrom( backgroundColor: Theme.of(context).colorScheme.primary, foregroundColor: Theme.of(context).colorScheme.onPrimary, elevation: 2, shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0), ), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), ), ),
        cardTheme: CardTheme( elevation: 1, shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12.0), side: BorderSide(color: Colors.grey.shade200, width: 1) ), clipBehavior: Clip.antiAlias, )
      ),
      debugShowCheckedModeBanner: false,
      // Layar Awal Sekarang adalah SplashScreen
      home: const SplashScreen(), // <<< GANTI home MENJADI SplashScreen
    );
  }
}