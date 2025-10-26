import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

// Paleta da tela de login (mockup)
class AppColors {
  static const Color primary = Color(0xFF3C6E91); // título/ícone
  static const Color bg      = Color(0xFFF2F8FB); // fundo claro
  static const Color input   = Color(0xFFD3E7EF); // campo preenchido
  static const Color accent  = Color(0xFF9EC6D8); // botão redondo seta
  static const Color text    = Color(0xFF4E4E4E); // cinza escuro
  static const Color muted   = Color(0xFF8A8A8A); // legenda/link
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Mantive sua geração de dados mock
  StationData buildStationData() {
    final tempSeries = List.generate(30, (i) => FlSpot(i.toDouble(), 20 + i * 0.2));
    final humSeries  = List.generate(30, (i) => FlSpot(i.toDouble(), 55 + (i % 6) * 2.0));
    final windSeries = List.generate(30, (i) => FlSpot(i.toDouble(), 8 + (i % 5) * 0.8));
    final pressSeries= List.generate(30, (i) => FlSpot(i.toDouble(), 1012 + (i % 4) * 1.0));
    final rainSeries = List.generate(30, (i) => FlSpot(i.toDouble(), (i % 8 == 0) ? 2.0 : 0.0));
    final luxSeries  = List.generate(30, (i) => FlSpot(i.toDouble(), 600 + (i % 10) * 30.0));

    return StationData(
      temperature: 25.4,
      humidity: 67.0,
      windSpeed: 12.3,
      pressure: 1012,
      rain: 1.5,
      luminosity: 850,
      history: {
        MetricId.temp: tempSeries,
        MetricId.hum: humSeries,
        MetricId.wind: windSeries,
        MetricId.press: pressSeries,
        MetricId.rain: rainSeries,
        MetricId.lux: luxSeries,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final station = buildStationData();

    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        surface: AppColors.bg,
        background: AppColors.bg,
      ),
      scaffoldBackgroundColor: AppColors.bg,

      // Tipografia semelhante ao mockup
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.text),
        titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.text),
        bodyMedium: TextStyle(
          fontSize: 14, color: AppColors.text),
      ),

      // Campos arredondados com preenchimento azul claro
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.input,
        hintStyle: const TextStyle(color: AppColors.muted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
      ),

      // Botões padrão (não o redondo da seta)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(56),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Meteorology',
      theme: theme,

      // Se quiser abrir direto no Login, troque para '/login'
      initialRoute: '/home',
      routes: {
        '/home': (_) => HomeScreen(),
        '/login': (_) => LoginScreen(station: station),
        '/dashboard': (_) => DashboardScreen(data: station),
      },
    );
  }
}
