import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/news_model.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsModel news;

  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('MMM dd, yyyy • h:mm a').format(news.timestamp);

    return Scaffold(
      appBar: AppBar(title: const Text("News Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (news.imageUrl != null && news.imageUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(news.imageUrl!),
              ),
            const SizedBox(height: 16),
            Text(
              news.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(date, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 12),
            Chip(label: Text(news.category)),
            const SizedBox(height: 20),
            Text(news.body, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

