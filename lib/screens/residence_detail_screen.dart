import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResidenceDetailScreen extends StatelessWidget {
  const ResidenceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF4E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF4E9),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Color(0xFF5A4635)),
          onPressed: () {
            Get.back();
          },
        ),
        title: Column(
          children: [
            Image.asset(
              'assets/images/logo_image.png',
              height: 40,
              color: const Color(0xFF5A4635),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 슬라이더
            SizedBox(
              height: 350,
              child: PageView.builder(
                itemCount: 3, // 예시 이미지 개수
                controller: PageController(viewportFraction: 0.9),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        'assets/images/room_image${index + 1}.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // 기본 정보
            const Text(
              '경기도 성남시 분당구',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text('정자일로 95, 1203호', style: TextStyle(color: Colors.grey)),
            const Text('보증금 W420000 / 월세 W100000 ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF5A4635),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                '마음 따뜻한 청년과 함께 하고 싶습니다.',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),

            // 계약 정보
            buildContractInfo('최대 계약 기간', '24개월'),
            const SizedBox(height: 16),

            // 유형
            buildTypeInfo('유형', '아파트', Icons.apartment),
            const SizedBox(height: 24),

            // 방 정보
            buildInfoSection('방 정보', ['도어락', '침대', '창문', '화장실', '와이파이']),
            const SizedBox(height: 24),

            // 허용 가능 여부
            buildInfoSection('허용 가능 여부', ['흡연']),
            const SizedBox(height: 24),

            // 식사 제공
            buildInfoSection('식사 제공', ['아침', '저녁']),
            const SizedBox(height: 40),

            // 거주자 정보
            const Text(
              '거주자 정보',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 수면 패턴
            buildSleepPattern(),
            const SizedBox(height: 16),

            // 상세 설명
            const Text(
              '상세 설명',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildContractInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget buildTypeInfo(String label, String type, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF5A4635),
              size: 25,
            ),
            const SizedBox(width: 8),
            Text(type, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ],
    );
  }

  Widget buildInfoSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            return Chip(
              label: Text(item),
              backgroundColor: Colors.white,
              labelStyle: const TextStyle(color: Color(0xFF5A4635)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildSleepPattern() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '수면 패턴',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: TextEditingController(text: '23'),
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '시작 시간',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text('시 ~'),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: TextEditingController(text: '8'),
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '종료 시간',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text('시'),
          ],
        ),
      ],
    );
  }
}
