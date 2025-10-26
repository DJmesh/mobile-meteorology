import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Modelo simples de dados da estação (snapshot atual + histórico por métrica)
class StationData {
  final double temperature;
  final double humidity;
  final double windSpeed;
  final double pressure;
  final double rain;
  final double luminosity;

  /// histórico genérico: chave = id da métrica, valor = lista de pontos (x,y)
  final Map<String, List<FlSpot>> history;

  const StationData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.rain,
    required this.luminosity,
    required this.history,
  });
}

/// Identificadores das métricas (para mapear no histórico)
class MetricId {
  static const temp = 'temperature';
  static const hum = 'humidity';
  static const wind = 'wind';
  static const press = 'pressure';
  static const rain = 'rain';
  static const lux = 'lux';
}

/// Tela principal do dashboard
class DashboardScreen extends StatelessWidget {
  final StationData data;

  const DashboardScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final items = [
      _DashboardItem("Temperatura", "${data.temperature.toStringAsFixed(1)} °C", Icons.thermostat, MetricId.temp, "°C"),
      _DashboardItem("Umidade", "${data.humidity.toStringAsFixed(0)} %", Icons.water_drop, MetricId.hum, "%"),
      _DashboardItem("Vento", "${data.windSpeed.toStringAsFixed(1)} km/h", Icons.air, MetricId.wind, "km/h"),
      _DashboardItem("Pressão", "${data.pressure.toStringAsFixed(0)} hPa", Icons.speed, MetricId.press, "hPa"),
      _DashboardItem("Chuva", "${data.rain.toStringAsFixed(1)} mm", Icons.umbrella, MetricId.rain, "mm"),
      _DashboardItem("Luminosidade", "${data.luminosity.toStringAsFixed(0)} lux", Icons.wb_sunny, MetricId.lux, "lux"),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFD),
      appBar: AppBar(
        title: const Text("Dashboard", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: 2,                   // ✅ 2 por linha
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: items.map((item) {
                return _DashboardCard(
                  item: item,
                  onTap: () {
                    final series = data.history[item.metricId] ?? const <FlSpot>[];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MetricChartPage(
                          title: item.title,
                          unit: item.unit,
                          spots: series,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

/// Modelo para cada card
class _DashboardItem {
  final String title;
  final String value;
  final IconData icon;
  final String metricId;
  final String unit;
  const _DashboardItem(this.title, this.value, this.icon, this.metricId, this.unit);
}

/// Card visual + clique
class _DashboardCard extends StatelessWidget {
  final _DashboardItem item;
  final VoidCallback onTap;
  const _DashboardCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xFFD7EAF4),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(2, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, size: 42, color: const Color(0xFF3C6E91)),
              const SizedBox(height: 12),
              Text(
                item.value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3C6E91),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Página de gráfico para uma métrica
class MetricChartPage extends StatelessWidget {
  final String title;
  final String unit;
  final List<FlSpot> spots; // pontos (x,y). x pode ser índice ou timestamp normalizado

  const MetricChartPage({
    super.key,
    required this.title,
    required this.unit,
    required this.spots,
  });

  @override
  Widget build(BuildContext context) {
    final hasData = spots.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: hasData
            ? LineChart(
                LineChartData(
                  minX: spots.first.x,
                  maxX: spots.last.x,
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) => touchedSpots.map((t) {
                        return LineTooltipItem(
                          '${t.y.toStringAsFixed(2)} $unit',
                          const TextStyle(fontWeight: FontWeight.w600),
                        );
                      }).toList(),
                    ),
                  ),
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 26,
                        interval: (spots.length / 4).clamp(1, 999).toDouble(),
                        getTitlesWidget: (value, meta) {
                          // Exemplo: mostrar o índice como inteiro
                          return Text(value.toInt().toString(),
                              style: const TextStyle(fontSize: 11));
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) =>
                            Text('${value.toStringAsFixed(0)}',
                                style: const TextStyle(fontSize: 11)),
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black12),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              )
            : const Center(child: Text('Sem dados para exibir')),
      ),
    );
  }
}
