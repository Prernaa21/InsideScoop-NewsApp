import 'package:flutter/material.dart';
import 'package:insidescoop/section/article_section.dart';

class SearchPage extends StatefulWidget {
  final List<ArticleSection> posts;

  SearchPage({@required this.posts});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ArticleSection> _searchedPost = [];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: 'Search News',
              hintStyle: TextStyle(color: Colors.blueGrey),
              border: InputBorder.none
          ),
          onChanged: (val){
            setState(() {
              _searchedPost = widget.posts.where(
                      (el)=>el.title.contains(val)
              ).toList();
            });
          },
        ),
      ),

      body: _searchedPost.isEmpty ?
      Center(
        child: Text('No match',style: TextStyle(fontSize: 20)),
      ):
      ListView.builder(
        itemCount: _searchedPost.length,
        itemBuilder: (ctx,i){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(_searchedPost[i].title),
                subtitle: Text(_searchedPost[i].content),
              ),
              Divider(height: 0,)
            ],
          );
        },
      ),
    );
  }
}
