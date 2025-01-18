import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'residence_detail_screen.dart';
import 'residence_input_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF4E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF4E9),
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 8.0),
          child: Image.asset(
            'assets/images/logo_image.png',
            height: 40,
            color: const Color(0xFF5A4635),
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '최신순',
              style: TextStyle(
                  color: Color(0xFF5A4635),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => const ResidenceInputScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 20.0, 8.0),
                  child: Image.asset(
                    'assets/images/add_info.png',
                    height: 38,
                    color: const Color(0xFF5A4635),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10, // 예시로 10개의 아이템
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => const ResidenceDetailScreen());
            },
            child: const ResidenceInfoCard(
              imagePaths: [
                'assets/images/room_image1.jpg',
                'assets/images/room_image2.jpg',
                'assets/images/room_image3.jpg',
                'assets/images/room_image4.jpg',
              ],
              name: '경기도 성남시 분당구',
              address: '정자일로 95, 1203호',
              deposit: '보증금 W420000',
              rent: '월세 W100000',
              introduction: '마음 따뜻한 청년과 함께 하고 싶습니다.',
            ),
          );
        },
      ),
    );
  }
}

class ResidenceInfoCard extends StatelessWidget {
  final List<String> imagePaths;
  final String name;
  final String address;
  final String deposit;
  final String rent;
  final String introduction;

  const ResidenceInfoCard({
    super.key,
    required this.imagePaths,
    required this.name,
    required this.address,
    required this.deposit,
    required this.rent,
    required this.introduction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              itemCount: imagePaths.length,
              controller: PageController(viewportFraction: 0.9),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imagePaths[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(address, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text('$deposit / $rent',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5A4635),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    introduction,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
