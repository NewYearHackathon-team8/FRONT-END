import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/residence.dart';
import '../controllers/auth_controller.dart';

class ResidenceController extends GetxController {
  final Dio dio;
  final RxList<Residence> residences = <Residence>[].obs;
  final RxBool isLoading = false.obs;

  ResidenceController({required this.dio});

  @override
  void onInit() {
    super.onInit();
    fetchResidences();
  }

  Future<void> fetchResidences() async {
    try {
      isLoading.value = true;

      print('매물 목록 요청 시작');
      print('BaseURL: ${dio.options.baseUrl}');
      print('Headers: ${dio.options.headers}');

      final response = await dio.get(
        '/gdc/supplier-list',
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${Get.find<AuthController>().accessToken.value}',
          },
        ),
      );

      print('매물 목록 응답 상태 코드: ${response.statusCode}');
      print('매물 목록 응답 데이터: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        residences.value =
            data.map((json) => Residence.fromJson(json)).toList();
        print('매물 개수: ${residences.length}');

        Get.snackbar(
          '성공',
          response.data['message'] ?? '매물 목록을 불러왔습니다.',
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      print('매물 목록 조회 에러 상세: $e');
      print('에러 스택트레이스: ${(e as DioException).stackTrace}');
      print('에러 타입: ${e.type}');
      print('에러 메시지: ${e.message}');
      if (e.response != null) {
        print('에러 응답 데이터: ${e.response?.data}');
        print('에러 응답 상태 코드: ${e.response?.statusCode}');
      }

      Get.snackbar(
        '오류',
        '매물 목록을 불러오는데 실패했습니다.',
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
