import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:hanjiboong/screens/main_screen.dart';

class AuthController extends GetxController {
  final dio = Dio();
  var isLoggedIn = false.obs;
  var accessToken = ''.obs;
  var refreshToken = ''.obs;

  // API 기본 URL을 로컬 서버로 설정합니다
  final String baseUrl = 'http://localhost:8080';

  Future<void> login(String email, String password) async {
    try {
      final response = await dio.post(
        '$baseUrl/gdc/log-in',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // API 응답에서 토큰들을 추출합니다
        accessToken.value = response.data['accessToken'];
        refreshToken.value = response.data['refreshToken'];
        isLoggedIn.value = true;

        // dio 인스턴스의 기본 헤더에 accessToken을 설정합니다
        dio.options.headers['Authorization'] = 'Bearer ${accessToken.value}';

        Get.snackbar('성공', '로그인되었습니다');
        Get.offAll(() => const MainScreen());
      }
    } catch (e) {
      print('로그인 에러: $e');
      Get.snackbar('오류', '로그인에 실패했습니다');
      logout();
    }
  }

  void logout() {
    accessToken.value = '';
    refreshToken.value = '';
    isLoggedIn.value = false;
    dio.options.headers.remove('Authorization');
  }
}
