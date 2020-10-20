import 'package:flutter/material.dart';
import 'package:news_project_with_api/helper/news.dart';
import 'package:news_project_with_api/models/news_model.dart';
import 'package:news_project_with_api/helper/getCategories.dart';
import 'package:news_project_with_api/views/home.dart';
class CategoryNews extends StatefulWidget {
    final String newsCategory;
    CategoryNews({this.newsCategory});
    CategoryNewsState createState()=> CategoryNewsState();
}

class CategoryNewsState extends State<CategoryNews> {
    List<Article> newsList = new List<Article>();
    bool _loading = true;

    void initState() {
        super.initState();
        getNews();
    }

    void getNews() async {
        NewsForCategorie newsForCategorie= new NewsForCategorie();
        await newsForCategorie.getNewsForCategory(widget.newsCategory);
        newsList = newsForCategorie.news;
        print('newsList $newsList');
        setState(() {
          _loading= false;
        });
    }
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Row(
                    children: [
                        Text('Flutter ', style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w600
                        ),),
                        Text('News', style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w600
                        ),),
                    ],
                ),
                elevation: 0.0,
            ),
            body: _loading? Center(
                child: CircularProgressIndicator(),
            ) : SingleChildScrollView(
                child: Container(
                    child: Container(
                        margin: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                            itemCount: newsList.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                                return NewsTile(
                                    imageUrl: newsList[index].imageUrl ?? " ",
                                    title: newsList[index].title ?? " ",
                                    description: newsList[index].title ?? " ",
                                    content: newsList[index].content ?? " ",
                                    postUrl: newsList[index].articleUrl ?? " ",

                                );
                            },
                        ),
                    ),
                ),
            ),
        );
    }
}