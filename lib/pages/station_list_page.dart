import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String title;
  final String? selectedStation;

  const StationListPage({super.key, required this.title, this.selectedStation});

  @override
  Widget build(BuildContext context) {
    final stations = [
      "수서",
      "동탄",
      "평택지제",
      "천안아산",
      "오송",
      "대전",
      "김천구미",
      "동대구",
      "경주",
      "울산",
      "부산",
    ];

    final filteredStations =
        stations.where((station) => station != selectedStation).toList();

    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: ListView.builder(
        itemCount: filteredStations.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: ListTile(
              title: Text(
                filteredStations[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context, filteredStations[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
