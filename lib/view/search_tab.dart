import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/widgets/search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchBarController<Post> _searchBarController = SearchBarController();
  bool isReplay = false;

  Future<List<Post>> _getALlPosts(String text) async {
    await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));
    if (isReplay) return [Post("Replaying !", "Replaying body")];
    if (text.length == 5) throw Error();
    if (text.length == 6) return [];
    List<Post> posts = [];

    var random = new Random();
    for (int i = 0; i < 10; i++) {
      posts.add(Post("$text $i", "body random number : ${random.nextInt(100)}"));
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: SafeArea(
          child: SearchBar<Post>(
            searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
            headerPadding: EdgeInsets.symmetric(horizontal: 10),
            listPadding: EdgeInsets.symmetric(horizontal: 10),
            onSearch: _getALlPosts,
            searchBarController: _searchBarController,
            placeHolder: Container(
              color: Colors.blue,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            cancellationWidget: Text("Cancel"),
            emptyWidget: Text("empty"),
            indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
            header: Row(
              children: <Widget>[
                RaisedButton(
                  child: Text("sort"),
                  onPressed: () {
                    _searchBarController.sortList((Post a, Post b) {
                      return a.body.compareTo(b.body);
                    });
                  },
                ),
                RaisedButton(
                  child: Text("Desort"),
                  onPressed: () {
                    _searchBarController.removeSort();
                  },
                ),
                RaisedButton(
                  child: Text("Replay"),
                  onPressed: () {
                    isReplay = !isReplay;
                    _searchBarController.replayLastSearch();
                  },
                ),
              ],
            ),
            onCancelled: () {
              print("Cancelled triggered");
            },
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            onItemFound: (Post post, int index) {
              return Container(
                color: Colors.lightBlue,
                child: ListTile(
                  title: Text(post.title),
                  isThreeLine: true,
                  subtitle: Text(post.body),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}