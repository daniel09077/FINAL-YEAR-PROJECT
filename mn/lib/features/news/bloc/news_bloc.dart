import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import './../data/models/news_model.dart';
import '../../news/data/repositories/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc(this.repository) : super(NewsLoading()) {
    on<LoadNews>(_onLoadNews);
  }

  void _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    await emit.forEach<List<NewsModel>>(
      repository.getNewsStream(),
      onData: (newsList) => NewsLoaded(newsList),
      onError: (_, __) => const NewsError("Failed to load news."),
    );
  }
}
