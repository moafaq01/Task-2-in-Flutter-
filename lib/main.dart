import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/cart_provider.dart';
import 'providers/favorites_provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const RafoufApp());
}

class RafoufApp extends StatelessWidget {
  const RafoufApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp(
        title: 'Rafouf Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color.fromARGB(255, 17, 75, 75),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 135, 187, 129),
            brightness: Brightness.light,
            primary: const Color(0xFF8BA888),
            secondary: const Color(0xFFD4A373),
            surface: Colors.white,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: Color(0xFF4A4A4A)),
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A4A4A),
            ),
          ),
          cardTheme: CardThemeData(
            color: const Color.fromARGB(255, 110, 69, 50),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
