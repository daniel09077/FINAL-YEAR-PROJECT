import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/news_model.dart';

class NewsRepository {
  final _newsCollection = FirebaseFirestore.instance.collection('news');

  Stream<List<NewsModel>> getNewsStream() {
    return _newsCollection.orderBy('timestamp', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => NewsModel.fromDoc(doc)).toList(),
    );
  }

  Future<void> addNews(NewsModel news) async {
    await _newsCollection.add(news.toMap());
  }
}
