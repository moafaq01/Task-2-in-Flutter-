import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/cart_provider.dart';
import 'providers/favorites_provider.dart';
import 'screens/main_screen.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تحميل البيانات المحفوظة قبل بناء الواجهة
  final storage = StorageService();
  final cartProvider = CartProvider();
  final favoritesProvider = FavoritesProvider();

  await Future.wait([
    cartProvider.loadFromStorage(),
    favoritesProvider.loadFromStorage(storage),
  ]);

  runApp(RafoufApp(
    cartProvider: cartProvider,
    favoritesProvider: favoritesProvider,
  ));
}

class RafoufApp extends StatelessWidget {
  final CartProvider cartProvider;
  final FavoritesProvider favoritesProvider;

  const RafoufApp({
    super.key,
    required this.cartProvider,
    required this.favoritesProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: cartProvider),
        ChangeNotifierProvider.value(value: favoritesProvider),
      ],
      child: MaterialApp(
        title: 'Rofoof Book',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0F172A),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF00E5FF),
            brightness: Brightness.dark,
            primary: const Color(0xFF00E5FF),
            secondary: const Color(0xFFFF007F),
            surface: const Color(0xFF1E293B),
          ),
          textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
              shadows: [Shadow(color: Color(0xFF00E5FF), blurRadius: 10)],
            ),
          ),
          cardTheme: CardThemeData(
            color: const Color(0xFF1E293B),
            elevation: 8,
            shadowColor: const Color(0xFF00E5FF).withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: const Color(0xFF00E5FF).withValues(alpha: 0.5),
                width: 1,
              ),
            ),
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
