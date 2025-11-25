import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Font
import 'models/user_model.dart';
import 'models/movie_model.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/local_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Registrasi Adapter (Pastikan file .g.dart sudah digenerate)
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(MovieAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modern Movie App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(
          0xFFF5F7FA,
        ), // Background abu-abu muda lembut
        // Skema Warna Indigo & Pink/Red
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5C6BC0),
          primary: const Color(0xFF5C6BC0),
          secondary: const Color(0xFFFF6B6B),
        ),

        // Font Global: Poppins
        textTheme: GoogleFonts.poppinsTextTheme(),

        // Tema AppBar default transparan & teks hitam
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: const Color(0xFF2D3436),
          centerTitle: false,
          titleTextStyle: GoogleFonts.poppins(
            color: const Color(0xFF2D3436),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: FutureBuilder<String?>(
        future: LocalService().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            return const HomeScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
