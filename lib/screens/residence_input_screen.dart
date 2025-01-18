import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:flutter/services.dart';

class ResidenceInputScreen extends StatefulWidget {
  const ResidenceInputScreen({super.key});

  @override
  _ResidenceInputScreenState createState() => _ResidenceInputScreenState();
}

class _ResidenceInputScreenState extends State<ResidenceInputScreen> {
  String? selectedImagePath;
  List<String> imagePaths = [];

  final List<String> types = ['단독 주택', '아파트 또는 빌라'];
  final List<String> roomInfo = [
    '침대',
    '침구류',
    '창문',
    '화장실',
    '주방',
    '세탁기',
    '테라스',
    '와이파이'
  ];
  final List<String> permissions = ['흡연', '애완동물'];
  final List<String> meals = ['아침', '점심', '저녁', '없음'];

  final Map<String, bool> selected = {};

  final TextEditingController contractPeriodController =
      TextEditingController();
  final TextEditingController depositController = TextEditingController();
  final TextEditingController monthlyRentController = TextEditingController();
  final TextEditingController sleepStartController = TextEditingController();
  final TextEditingController sleepEndController = TextEditingController();
  final TextEditingController introductionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  Future<void> _addressAPI() async {
    KopoModel model = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => RemediKopo(),
      ),
    );
    setState(() {
      _addressController.text =
          '${model.zonecode ?? ''} ${model.address ?? ''} ${model.buildingName ?? ''}';
    });
  }

  @override
  void initState() {
    super.initState();
    for (var item in [...types, ...roomInfo, ...permissions, ...meals]) {
      selected[item] = false;
    }
  }

  void toggleSelection(String item) {
    setState(() {
      selected[item] = !(selected[item] ?? false);
    });
  }

  void selectType(String type) {
    setState(() {
      for (var item in types) {
        selected[item] = false;
      }
      selected[type] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF4E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF4E9),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Color(0xFF5A4635)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo_image.png',
          height: 40,
          fit: BoxFit.contain,
        ),
      ),
      // extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '거주지 정보',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 350,
                child: PageView.builder(
                  itemCount: imagePaths.length + 1,
                  controller: PageController(viewportFraction: 0.8),
                  itemBuilder: (context, index) {
                    if (index == imagePaths.length) {
                      return GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                          );

                          if (image != null) {
                            setState(() {
                              imagePaths.add(image.path);
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child:
                                Icon(Icons.add, size: 50, color: Colors.grey),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(imagePaths[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                  child: Text(
                '집과 방 사진을 올려주세요',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              )),
              const SizedBox(height: 5),
              const Center(
                  child: Text(
                '(거실전경, 주방, 화장실, 수요자 전용방, 현관)',
                style: TextStyle(fontSize: 13),
                textAlign: TextAlign.center,
              )),
              const SizedBox(
                height: 24,
              ),

              // 계약 정보 UI 추가
              buildContractInfoField(
                  '최대 계약 기간', contractPeriodController, '개월'),
              const SizedBox(height: 16),
              buildContractInfoField('보증금', depositController, '원'),
              const SizedBox(height: 16),
              buildContractInfoField('월세', monthlyRentController, '원'),
              const SizedBox(height: 24),

              // 주소 UI 추가
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  _addressAPI();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '주소',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _addressController,
                      enabled: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        hintText: '주소를 입력하세요',
                      ),
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 유형 UI 추가
              const Text(
                '유형',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(child: buildTypeButton('단독 주택', Icons.home)),
                    const SizedBox(width: 8),
                    Expanded(
                        child: buildTypeButton('아파트 또는 빌라', Icons.apartment)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 방 정보 UI 추가
              const Text(
                '방 정보',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: roomInfo.map((item) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: (selected[item] ?? false)
                          ? Colors.black
                          : Colors.white,
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () => toggleSelection(item),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: (selected[item] ?? false)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // 허용 가능 여부 UI 추가
              const Text(
                '허용 가능 여부',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: permissions.map((item) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: (selected[item] ?? false)
                          ? Colors.black
                          : Colors.white,
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () => toggleSelection(item),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: (selected[item] ?? false)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              const Text(
                '식사 제공',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                '*필수 항목이 아닙니다.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: meals.map((item) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: (selected[item] ?? false)
                          ? Colors.black
                          : Colors.white,
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () => toggleSelection(item),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: (selected[item] ?? false)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
              const Text(
                '거주자 정보',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // 수면 패턴 UI 추가
              const Text(
                '수면 패턴',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: sleepStartController,
                      keyboardType: TextInputType.number,
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
                      controller: sleepEndController,
                      keyboardType: TextInputType.number,
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
              const SizedBox(height: 16),

              // 한 줄 소개 UI 추가
              const Text(
                '한 줄 소개',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: introductionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '한 줄 소개를 입력하세요',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 16),

              // 상세 설명 UI 추가
              const Text(
                '상세 설명',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                maxLines: 7,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '특이사항이나 집에 대한 설명을 적어주세요.',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 40),

              // 등록하기 버튼 추가
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // 등록하기 버튼 클릭 시 처리할 로직 추가
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('등록하기'),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTypeButton(String type, IconData icon) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor:
            (selected[type] ?? false) ? Colors.black : Colors.white,
        side: const BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      onPressed: () => selectType(type),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon,
              color: (selected[type] ?? false) ? Colors.white : Colors.black),
          const SizedBox(height: 8),
          Text(
            type,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: (selected[type] ?? false) ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContractInfoField(
      String label, TextEditingController controller, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  textAlign: TextAlign.right,
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(unit),
            ],
          ),
        ),
      ],
    );
  }
}
