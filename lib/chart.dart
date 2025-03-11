import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'db_helper.dart'; // Ensure this is correctly linked

class HighScoresPage extends StatefulWidget {
  @override
  _HighScoresPageState createState() => _HighScoresPageState();
}

class _HighScoresPageState extends State<HighScoresPage> {
  List<Map<String, dynamic>> highScores = [];
  List<FlSpot> dailyScoreData = [];

  @override
  void initState() {
    super.initState();
    _loadHighScores();
    _loadDailyScores();
  }

  Future<void> _loadHighScores() async {
    final db = await DatabaseHelper().database;
    final scores = await db.query('max_scores');
    setState(() {
      highScores = scores;
    });
  }

  List<String> dates = []; // Add this as a class variable

  Future<void> _loadDailyScores() async {
    final db = await DatabaseHelper().database;
    final scores = await db.rawQuery(
        "SELECT date, SUM(score) as total_score FROM daily_scores GROUP BY date ORDER BY date ASC");

    setState(() {
      dates = scores.map((entry) => entry['date'].toString()).toList(); // Store dates
      dailyScoreData = scores.asMap().entries.map((entry) {
        int index = entry.key;
        double totalScore = (entry.value['total_score'] as int).toDouble();
        return FlSpot(index.toDouble(), totalScore);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Scores")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Category High Scores", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(child: buildHighScoresList()),

            SizedBox(height: 20),
            Text("Daily Score Progress", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(height: 250, child: buildScoreChart()),
          ],
        ),
      ),
    );
  }

  Widget buildHighScoresList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: highScores.length,
      itemBuilder: (context, index) {
        final score = highScores[index];
        return Card(
          child: ListTile(
            title: Text(score['name'].toString().toUpperCase()),
            trailing: Text("Max Score: ${score['max_score']}"),
          ),
        );
      },
    );
  }

  Widget buildScoreChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString()); // Display integer values on the y-axis
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                // Ensure the index is within the valid range
                if (value.toInt() < dates.length) {
                  return Text(dates[value.toInt()]); // Display the date
                }
                return Text('');
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: dailyScoreData,
            isCurved: true,
            color: Colors.blue,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          )
        ],
        minY: 0, // Set the minimum y-axis value to 0
      ),
    );
  }
}
