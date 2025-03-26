import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:provider/provider.dart';
import '../main.dart';
import 'station_list_page.dart';
import 'seat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departureStation;
  String? arrivalStation;

  void _selectStation(bool isDeparture) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => StationListPage(
              title: isDeparture ? '출발역' : '도착역',
              selectedStation: isDeparture ? arrivalStation : departureStation,
            ),
      ),
    );

    if (result != null) {
      setState(() {
        if (isDeparture) {
          departureStation = result;
        } else {
          arrivalStation = result;
        }
      });
    }
  }

  void resetStations() {
    setState(() {
      departureStation = null;
      arrivalStation = null;
    });
  }

  void _swapStations() {
    setState(() {
      final temp = departureStation;
      departureStation = arrivalStation;
      arrivalStation = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('기차 예매'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: themeProvider.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectStation(true),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '출발역',
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  isDarkMode ? Colors.grey[400] : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            departureStation ?? '선택',
                            style: TextStyle(
                              fontSize: 40,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _swapStations,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Transform.rotate(
                        angle: 3 * pi / 4,
                        child: Icon(
                          Icons.sync,
                          size: 30,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectStation(false),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '도착역',
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  isDarkMode ? Colors.grey[400] : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            arrivalStation ?? '선택',
                            style: TextStyle(
                              fontSize: 40,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  (departureStation != null && arrivalStation != null)
                      ? () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SeatPage(
                                  departureStation: departureStation!,
                                  arrivalStation: arrivalStation!,
                                ),
                          ),
                        );
                        resetStations();
                      }
                      : null,
              child: const Text(
                '좌석 선택',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
