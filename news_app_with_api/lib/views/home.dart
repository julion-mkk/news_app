import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_project_with_api/helper/getCategories.dart';
import 'package:news_project_with_api/models/categorie_model.dart';
import 'package:news_project_with_api/helper/news.dart';
import 'package:news_project_with_api/views/artical_view.dart';
import 'package:news_project_with_api/models/news_model.dart';
import 'package:news_project_with_api/views/category_news.dart';

class Home extends StatefulWidget {
    HomeState createState()=> HomeState();
}

class HomeState extends State<Home> {
    List<CategorieModel> categories= new List<CategorieModel>();
    List<Article> newsList = new List<Article>();
    bool _loading;

    void getNews() async {
        News news= new News();
        await news.getNews();
        newsList= news.news;
        setState(() {
          _loading= false;
        });
        print('MSSD ${newsList[0].articleUrl}');
    }

    void initState() {
        super.initState();
        _loading = true;
        getNews();

        categories = getCategories();

    }
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text('Flutter ',
                        style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600)),

                        Text('News',
                        style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600),),
                    ],
                ),
                elevation: 0.0,

            ),
            body: _loading? Center(
                child: CircularProgressIndicator(),
            ) : SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                            height: 70,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (context,index) {
                                    return NewsCard(
                                        imageUrl: categories[index].imageUrl,
                                        categoryName: categories[index].categoryName,
                                    );
                                },
                            ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 16),
                            child: ListView.builder(
                                itemCount: newsList.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                    return NewsTile(
                                        imageUrl: newsList[index].imageUrl ?? " ",
                                        description: newsList[index].description ?? " ",
                                        title: newsList[index].title ?? " ",
                                        postUrl: newsList[index].articleUrl ?? " ",
                                        content: newsList[index].content ?? " ",
                                    );
                                },
                            ),
                        )
                    ],
                ),
            )
        );
    }
}

class NewsCard extends StatelessWidget {
    final String imageUrl, categoryName;

    NewsCard({this.imageUrl,this.categoryName});
    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> CategoryNews(
                        newsCategory: categoryName.toLowerCase()
                    )
                ));
            },
            child: Container(
                padding: EdgeInsets.only(right: 14.0),
                child: Stack(
                    children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                height: 60,
                                width: 120,
                                fit: BoxFit.cover,
                            ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black26,
                            ),
                            child: Text(
                                categoryName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),
                            ),
                        )
                    ],
                ),
            ),
        );
    }
}

class NewsTile extends StatelessWidget {
    final String imageUrl, title, description, content, postUrl;

    NewsTile({this.imageUrl, this.title, this.description, this.content, @required this.postUrl});

    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: () {
                Navigator.push(context,MaterialPageRoute(
                    builder: (context) => ArticleView(
                        postUrl: postUrl,
                    )
                ));
            },
            child: Container(
                margin: EdgeInsets.only(bottom: 24),
                width: MediaQuery.of(context).size.width,
                child: Container(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6))
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                        imageUrl,
                                        width: MediaQuery.of(context).size.width,
                                        height: 200,
                                        fit: BoxFit.cover,
                                    ),
                                ),
                                SizedBox(
                                    height: 16,
                                ),
                                Text(
                                    title,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                    ),
                                ),
                                SizedBox(
                                    height: 4,
                                ),
                                Text(
                                    description,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14
                                    ),
                                )
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}