import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
    String postUrl;
    ArticleView({this.postUrl});
    ArticleViewState createState()=> ArticleViewState();
}

class ArticleViewState extends State<ArticleView> {
    final Completer<WebViewController> webViewControll= Completer<WebViewController>();

    void initState() {
        print('hello ${widget.postUrl}');
    }

    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Row(
                    children: [
                        Text('Flutter ',
                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),),

                        Text('News',
                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),)
                    ],
                ),
                elevation: 0.0,
            ),
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: WebView(
                    initialUrl:  widget.postUrl,
                    onWebViewCreated: (WebViewController webViewController){
                        webViewControll.complete(webViewController);
                    },
                ),
            ),
        );
    }
}