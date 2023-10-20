import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_04/post_view_model.dart';
import 'package:flutter_riverpod_04/session_provider.dart';

/// 버튼 클릭시 사진 변경
class PostPage extends ConsumerWidget {
  PostPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("나 빌드됨");

    PostModel? model = ref.watch(postProvider);
    // 구독하면 최초의 데이터를 준다. null 일 수 있다.

    if (model == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network("https://picsum.photos/id/60/200/300",
                  fit: BoxFit.cover),
            ),
            Text(
                "id : ${model.id}, userId : ${model.userId}, title :${model.title}"),
            // 상수 등록
            ElevatedButton(
                onPressed: () {
                  ref.read(postProvider.notifier).change(); // 값 변경 + rebuild
                },
                child: Text("값변경")),
            ElevatedButton(
                onPressed: () {
                  SessionUser sessionUser = ref.read(sessionProvider); // 값 변경
                  sessionUser.isLogin = true;
                },
                child: Text("로그인")),
          ],
        ),
      );
    }
  }
}
