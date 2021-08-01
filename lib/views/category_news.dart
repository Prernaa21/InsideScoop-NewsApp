import 'package:flutter/material.dart';
import 'package:insidescoop/helper/news.dart';
import 'package:insidescoop/helper/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insidescoop/section/article_section.dart';
import 'package:insidescoop/views/search_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleSection> articles = [];
  bool _loading = true;

  int currentIndex = 0;
  bool _isSearching = false;


  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !_isSearching ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Inside", style: GoogleFonts.pacifico(color: Colors.black, ),),
            Text(
              "Scoop",
              style: GoogleFonts.pacifico(color: Colors.red[900], ),
            )
          ],
        )
        : TextField(decoration: InputDecoration(

          icon: Icon(Icons.search),

            hintText: 'Search' )
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx)=> SearchPage(posts: articles,)
             ));
            },
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
          child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
          children: <Widget>[
           Container(
            padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        publishedAt: articles[index].publishedAt,
                        blogUrl: articles[index].url,
                      );
                    }),
              ),
        ]),
          ),
      ) );
  }
}

