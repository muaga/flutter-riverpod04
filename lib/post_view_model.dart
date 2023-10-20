import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_04/post_repository.dart';
import 'package:flutter_riverpod_04/session_provider.dart';

/// PostPage를 관리하는 창고
// 화면에 필요한 이미지를 보고 작성

/// 1. 창고 데이터(model)
class PostModel {
  int id;
  int userId;
  String title;

  PostModel(this.id, this.userId, this.title);

  /// 통신으로 받을 생성자 생성
  PostModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        userId = json["userId"],
        title = json["title"];
}

/// 2. 창고(view model) + 초기화 메소드
class PostViewModel extends StateNotifier<PostModel?> {
  // 생성자를 통해 상태를 부모에게 전달
  PostViewModel(super.state, this.ref);

  Ref ref; // 창고에서 ref를 사용하는 방법

  // 상태 초기화(필수)
  void init() async {
    // 통신 코드
    PostModel postModel = await PostRespository().fetchPost(40);

    /// 통신을 통해 상태 변경(그림이 총 2번 그려진다)
    state = postModel;
  }

  // 상태 변경
  void change() async {
    // 로그인 상태에 따라 다르게 실행되도록 분리할 수 있다.

    SessionUser sessionUser = ref.read(sessionProvider);
    if (sessionUser.isLogin) {
      PostModel postModel = await PostRespository().fetchPost(50);
      state = postModel;
    }
  }
}

/// 3. 창고 관리자(provider) = 창고 접근(read, watch) -> 생명주기(UI가 파괴될 때, provider도 자동 파괴되도록 도와준다 = autoDispose)
final postProvider =
    StateNotifierProvider.autoDispose<PostViewModel, PostModel?>((ref) {
  return PostViewModel(null, ref)..init();
});
// ★★ autoDispose : 화면 중 더 이상 필요없는 화면일 때, memory도 소멸된다. (메모리 관리)
