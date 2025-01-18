import 'package:flutter/material.dart';

class MainScreenForProvider extends StatelessWidget {
  const MainScreenForProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo_image.png'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '등록된 방이 없습니다',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '공유할 방을 등록해보세요!',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // 등록하기 버튼 클릭 시 동작
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF443927), // 버튼 색상
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            '등록하기',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          
        ),
        
      ),
      
    );
  }
}
