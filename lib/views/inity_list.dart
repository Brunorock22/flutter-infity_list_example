import 'package:flutter/material.dart';
import 'package:flutterinfinitylist/backend/backend.dart';
import 'package:dio/dio.dart';
import 'package:flutterinfinitylist/backend/backend_routes.dart';
import 'package:flutterinfinitylist/model/new.dart';

class InfinityListScreen extends StatefulWidget {
  @override
  _InfinityListScreenState createState() => new _InfinityListScreenState();
}

class _InfinityListScreenState extends State<InfinityListScreen> {
  var news = List<New>();
  var isLast = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Infinite List"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index < news.length) {
            return news[index].title != null
                ? ListTile(title: Text(news[index].title))
                : SizedBox();
          } else {
            isLast == false ? getMoreNews(index) : Container();
            return Center(child: CircularProgressIndicator());
          }
        },
        itemCount: news.length + 1,
      ),
    );
  }

  List errors;
  Backend backend = Backend.instance();
  Response r;

  Future<List<New>> getMoreNews(int page) async {
    try {
      backend.addToken();
      r = await backend.io
          .get(BackendRoutes.news + '?page=' + page.toString() + '&size=10');
      if (r.statusCode == 200) {
        var json = r.data;

        List items = json["content"];
        Map<String, dynamic> lastMap = {"last": json['last']};
        items.add(lastMap);
        for (int i = 0; i < items.length; i++) {
          news.add(New.fromJson(items[i]));
        }
        setState(() {
          isLast = lastMap['last'];
        });
        return news;
      }
    } catch (e) {
      errors = backend.interceptor.errors;

      return null;
    }
  }
}
