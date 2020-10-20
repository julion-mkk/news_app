import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_project_with_api/models/news_model.dart';

class News {
    List<Article> news = [];

    Future<void> getNews() async {
        String apiKey = '37a05f274d9a409d814a7cd277afaab4';
        String url = "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=$apiKey";
        var response = await http.get(url);
        print('MKK ${response.body}');
        var jsonResponse= jsonDecode(response.body);
        if(jsonResponse['status'] == 'ok') {
            jsonResponse['articles'].forEach((element) {
                if(element['urlToImage'] != null && element['description'] != null) {
                    Article article= Article(
                        title: element['title'],
                        author: element['author'],
                        description: element['description'],
                        imageUrl: element['urlToImage'],
                        publishedAt: DateTime.parse(element['publishedAt']),
                        content: element['content'],
                        articleUrl: element['url']
                    );
                    news.add(article);
                }
            });
        }
    }
}

class NewsForCategorie {

    List<Article> news = [];

    Future<void> getNewsForCategory(String category) async {

        /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
        String apiKey = '37a05f274d9a409d814a7cd277afaab4';
        String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=$apiKey";

        var response = await http.get(url);

        var jsonData = jsonDecode(response.body);

        if (jsonData['status'] == "ok") {
            jsonData["articles"].forEach((element) {
                if (element['urlToImage'] != null &&
                    element['description'] != null) {
                    Article article = Article(
                        title: element['title'],
                        author: element['author'],
                        description: element['description'],
                        imageUrl: element['urlToImage'],
                        publishedAt: DateTime.parse(element['publishedAt']),
                        content: element["content"],
                        articleUrl: element["url"],
                    );
                    news.add(article);
                }
            });
            print('chosenCat $news');
        }
    }
}