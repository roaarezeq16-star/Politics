import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PoliticsApp());
}

class PoliticsApp extends StatelessWidget {
  const PoliticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'التوعية السياسية - الأردن',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Force RTL layout for Arabic
      locale: const Locale('ar', 'JO'),
      supportedLocales: const [
        Locale('ar', 'JO'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        // We use manual Arabic text so no complex localization delegates needed
      ],
      builder: (context, child) {
        // Force RTL directionality throughout the app
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const HomeScreen(),
    );
  }
}
