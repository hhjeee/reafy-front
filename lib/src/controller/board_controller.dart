import 'package:get/get.dart';
import 'package:reafy_front/src/models/memo.dart';

class BoardController extends GetxController {
  RxList<Memo> memoList = <Memo>[].obs;
  @override
  void onInit() {
    super.onInit();
    _loadFeedList();
  }

  void _loadFeedList() async {
    var feedList = [
      Memo(
        title: 'Post 1',
        content:
            'Content for post 1...Content for post 1...Content for post 1...Content for post 1...Content for post 1...Content for post 1...Content for post 1...Content for post 1...Content for post 1...',
        imageUrl:
            "https://marketplace.canva.com/EAD161UHRIg/1/0/1003w/canva-%ED%8C%8C%EB%9E%80%EC%83%89-%EC%82%AC%EC%A7%84-%EA%B3%BC%ED%95%99-%EC%86%8C%EC%84%A4-%EC%B1%85-%ED%91%9C%EC%A7%80-W-oW2VKWuGo.jpg",
      ),
      Memo(title: 'Post 2', content: 'Content for post 2...', imageUrl: "")
    ];
    //await PostRepository.loadFeedList();
    memoList.addAll(feedList);
  }
}


/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clone_instagram/src/models/post.dart';

class PostRepository {
  static Future<void> updatePost(Post postData) async {
    await FirebaseFirestore.instance.collection('posts').add(postData.toMap());
  }

  static Future<List<Post>> loadFeedList() async {
    var document = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(10);
    var data = await document.get();
    return data.docs.map<Post>((e) => Post.fromJson(e.id, e.data())).toList();
  }
}

*/