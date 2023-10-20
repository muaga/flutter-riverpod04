import 'package:dio/dio.dart';
import 'package:flutter_riverpod_04/post_view_model.dart';

/// 통신 코드 작성

class PostRespository {
//  return을 받으면 void가 아닐 수 있다.

  Dio dio = Dio();
  Future<PostModel> fetchPost(int id) async {
    /// 1. 통신 - 대기중
    final response =
        await dio.get("https://jsonplaceholder.typicode.com/posts/${id}");
    // path : JSON 통신 경로

    /// 2. 파싱
    PostModel postModel = PostModel.fromJson(response.data); // response = map

    /// 3. return
    return postModel;
  }
}
