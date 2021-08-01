import 'package:flutter/material.dart';
import 'package:insidescoop/views/article_view.dart';


Widget MyAppBar(){
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Ready",
          style:
          TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        Text(
          "News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
        )
      ],
    ),
    actions: <Widget>[
      Opacity(
        opacity: 0,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.save)),
      )
    ],
    centerTitle: true,
    elevation: 0.0,
  );
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, content, blogUrl, publishedAt;

  BlogTile({this.imageUrl, this.desc, this.title, this.content, this.publishedAt, @required this.blogUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Articleview(
                blogUrl: blogUrl,
              )
          ));
        },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              desc,
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}