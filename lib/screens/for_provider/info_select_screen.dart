import 'package:flutter/material.dart';

class InfoSelectScreen extends StatefulWidget {
  const InfoSelectScreen({super.key});

  @override
  _InfoSelectScreenState createState() => _InfoSelectScreenState();
}

class _InfoSelectScreenState extends State<InfoSelectScreen> {
  String _selectedOption = '';

  void _selectOption(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('한지붕'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildOptionButton(
              '직접 등록하기',
              '모든 정보를 직접 입력합니다.',
              Icons.edit,
              'direct',
            ),
            const SizedBox(height: 16),
            _buildOptionButton(
              '담당 직원 호출하기',
              '서비스 담당 직원이 방문하여 대신 정보를 수집하고 등록합니다.',
              Icons.person,
              'staff',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _selectedOption.isNotEmpty
              ? () {
                  // 다음 버튼 클릭 시 동작
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            '다음',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(
      String title, String subtitle, IconData icon, String option) {
    bool isSelected = _selectedOption == option;
    return GestureDetector(
      onTap: () => _selectOption(option),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.brown : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              icon,
              size: 40,
              color: isSelected ? Colors.white : Colors.brown,
            ),
          ],
        ),
      ),
    );
  }
}
