// view model = 개별 변수
// provider = 전역변수 -> 창고는 필요 없다.(화면 변경이 아니기 때문에)
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 로그인 session provider - 싱글톤으로 관리가 가능하다
/// 전역적인 데이터 관리용으로만 provider를 사용한다. -> 화면 변경이 아닌 데이터 관리

/// 1. 창고 데이터(model)
class SessionUser {
  String? jwt;
  bool isLogin; // 초기 = false / null

  SessionUser({this.jwt, this.isLogin = false});
}

/// 2. 창고 관리자, 상태 초기화(null)
final sessionProvider = Provider<SessionUser>((ref) {
  return SessionUser();
});
