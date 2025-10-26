import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Aqui você cria ou carrega os dados globais
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
    final station = buildStationData(); // gera uma instância dos dados

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (_) => HomeScreen(),
        '/login': (_) => LoginScreen(station: station),
        '/dashboard': (_) => DashboardScreen(data: station),
      },
    );
  }
}