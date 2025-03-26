import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  final List<String> seatLabels = ['A', 'B', 'C', 'D'];
  int? selectedRow;
  int? selectedCol;

  void _selectSeat(int row, int col) {
    setState(() {
      if (selectedRow == row && selectedCol == col) {
        selectedRow = null;
        selectedCol = null;
      } else {
        selectedRow = row;
        selectedCol = col;
      }
    });
  }

  bool get hasSelectedSeat {
    return selectedRow != null && selectedCol != null;
  }

  String get selectedSeatText {
    if (!hasSelectedSeat) return '';
    return '${selectedRow! + 1}-${seatLabels[selectedCol!]}';
  }

  void _showConfirmDialog() {
    showCupertinoDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: const Text('예매 확인'),
            content: Text('선택하신 좌석은 $selectedSeatText 입니다.\n예매하시겠습니까?'),
            actions: [
              CupertinoDialogAction(
                child: const Text('취소'),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                child: const Text('확인'),
                onPressed: () {
                  Navigator.pop(context); // 다이얼로그 닫기
                  Navigator.of(
                    context,
                  ).popUntil((route) => route.isFirst); // 홈페이지까지 돌아가기
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('좌석 선택'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.departureStation,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 30,
                  color: Colors.black,
                ),
                Expanded(
                  child: Text(
                    widget.arrivalStation,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('선택됨'),
                const SizedBox(width: 20),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('선택안됨'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: 20,
              itemBuilder: (context, row) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(2, (col) {
                        final isSelected =
                            selectedRow == row && selectedCol == col;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: GestureDetector(
                            onTap: () => _selectSeat(row, col),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Colors.purple
                                        : Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                seatLabels[col],
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          '${row + 1}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      ...List.generate(2, (col) {
                        final isSelected =
                            selectedRow == row && selectedCol == col + 2;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: GestureDetector(
                            onTap: () => _selectSeat(row, col + 2),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Colors.purple
                                        : Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                seatLabels[col + 2],
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: hasSelectedSeat ? _showConfirmDialog : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                '예매 하기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
