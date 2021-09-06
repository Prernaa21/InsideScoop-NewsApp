import 'package:flutter/material.dart';
import 'package:insidescoop/helper/news.dart';
import 'package:insidescoop/section/category_section.dart';
import 'package:insidescoop/helper/info.dart';
import 'package:insidescoop/views/category_news.dart';
import 'package:insidescoop/helper/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insidescoop/views/login_screen.dart';
import 'package:geolocator/geolocator.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


class _HomeState extends State<Home> {

  // ignore: deprecated_member_use
  List<CategorySection> categories = new List<CategorySection>();

  bool _loading = true;
  int currentIndex = 0;
  var articles;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    categories = getcategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  bool themeSwitch = false;

  dynamic themeColors() {
    if (themeSwitch) {
      return Colors.amber[100];
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          backgroundColor: themeColors(),
          brightness: themeSwitch ? Brightness.dark : Brightness.light,
          leading: IconButton(
            onPressed: () {
              setState((){
                themeSwitch = !themeSwitch;
              });
            },
            icon: themeSwitch
              ? Icon(Icons.visibility,
            color: themeSwitch ? Colors.indigo[900] :
            Colors.grey[850],)
                : Icon(
              Icons.wb_sunny,
              color: themeSwitch ? Colors.greenAccent :
            Colors.deepOrangeAccent,

            ),
            ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text(
                "Inside",
                style: GoogleFonts.pacifico(
                color: Colors.black87, fontWeight: FontWeight.w500,),
              ) ,
              Text(
                "Scoop",
                style: GoogleFonts.pacifico(color: Colors.red[900], fontWeight: FontWeight.w500),
              ),
            ],
          ),
          actions: <Widget>[
          Container(

        child: OutlinedButton(
        onPressed: () {
    FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(
    builder: (context) => LoginScreen()))
    ;
    },
      style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
          side: MaterialStateProperty.all(BorderSide(
            color: Colors.white,))),
        child: Text("Logout", style: TextStyle(color: Colors.black),
        )),
    ),
    ],
    elevation: 0.0,
        ),
        body: _loading
            ? Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        )
            : SingleChildScrollView(
          child: Container(
            color: themeColors(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[

                /// Categories
                Container(
                  margin: EdgeInsets.only(top: 25,),
                  height: 70,
                  child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          categoryName: categories[index].categoryName,
                        );
                      }),
                ),

                Container(
                  width: 350,
                    child: new Text(
                        'Latest News  ',textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                          color: (Colors.black),
                        )
                    )
                ),
                /// Blogs
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
                          content: articles[index].content,
                          publishedAt: articles[index].publishedAt,
                          blogUrl: articles[index].url,
                        );
                      }),
                )
              ],

            ),
          ),
        )
    );
  }
}




class CategoryTile extends StatelessWidget {
  final String categoryName;
  CategoryTile(
      {@required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                  category: categoryName.toLowerCase(),
                )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(

          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black)
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: GoogleFonts.montaga(
                    color: Colors.blueGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}


