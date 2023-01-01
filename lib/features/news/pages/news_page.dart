import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/utils/route_manager/data/repository/route_manager.dart';
import 'package:flutter_app_test/core/utils/route_manager/domain/entity/route.dart';
import 'package:flutter_app_test/features/news/viewmodel/news_viewmodel.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NewsViewModel>().fetchArticles(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: Consumer<NewsViewModel>(
        builder: (context, notifier, child) {
          if (notifier.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                key: Key('progress-indicator'),
              ),
            );
          }
          return ListView.builder(
            itemCount: notifier.articles.length,
            itemBuilder: (_, index) {
              final article = notifier.articles[index];
              return Card(
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    Go.to.page(articlePageRoute, argument: article);
                  },
                  child: ListTile(
                    title: Text(article.title),
                    subtitle: Text(
                      article.content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            },
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
          );
        },
      ),
    );
  }
}
