import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/providers/library_provider.dart';
import 'package:task2/screens/main_layout.dart';
import 'package:task2/theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LibraryProvider()),
      ],
      child: const RofofApp(),
    ),
  );
}

class RofofApp extends StatelessWidget {
  const RofofApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rofof Book',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainLayout(),
    );
  }
}
