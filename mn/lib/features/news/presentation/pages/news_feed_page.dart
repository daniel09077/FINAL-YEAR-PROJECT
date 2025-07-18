import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/news_bloc.dart';
import '../../data/models/news_model.dart';
import '../widgets/urgent_banner.dart';
import '../widgets/news_filter_section.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  String selectedCategory = 'All';

  List<NewsModel> _filterNews(List<NewsModel> list) {
    if (selectedCategory == 'All') return list;
    return list.where((news) => news.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kaduna Polytechnic")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            UrgentBanner(
              message: "Registration Deadline Extended to January 20th",
              onTap: () {},
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search news...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 12),
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return const Expanded(child: Center(child: CircularProgressIndicator()));
                } else if (state is NewsLoaded) {
                  final filteredNews = _filterNews(state.newsList);

                  return Expanded(
                    child: Column(
                      children: [
                        NewsFilterSection(
                          allCount: state.newsList.length,
                          adminCount: state.newsList.where((n) => n.category == 'Administration').length,
                          facultyCount: state.newsList.where((n) => n.category == 'Faculty').length,
                          studentBodyCount: state.newsList.where((n) => n.category == 'Student Body').length,
                          selectedCategory: selectedCategory,
                          onCategorySelected: (cat) => setState(() => selectedCategory = cat),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                            itemCount: filteredNews.length,
                            itemBuilder: (_, index) {
                              final news = filteredNews[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  title: Text(news.title),
                                  subtitle: Text(news.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                                  onTap: () {
                                    context.push('/news-detail', extra: news);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Expanded(child: Center(child: Text("Failed to load news.")));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
