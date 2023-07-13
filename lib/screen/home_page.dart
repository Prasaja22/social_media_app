import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pertemuan_6/models/post.dart';
import 'package:pertemuan_6/screen/pages/posting_page.dart';
import 'package:pertemuan_6/shared_pref.dart';
import 'package:readmore/readmore.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _handleRequest() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  var baseUrl = "https://b517-103-17-77-3.ngrok-free.app/api";

  Future<List<Post>> getData() async {
    var dio = Dio();
    var token = SharedPref.pref?.getString("token");
    try {
      var response = await dio.get(
        '$baseUrl/post',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      List<Post> listPosts =
          (response.data['data'] as List).map((e) => Post.fromJson(e)).toList();
      return listPosts;
    } catch (e) {
      print("Terjadi kesalahan saat mengambil data: $e");
      throw e;
    }
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.amber),
          brightness: isDark ? Brightness.dark : Brightness.light),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Posting(isDark: isDark);
                });
          },
          child: Icon(Icons.add_box),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              isDark == true
                  ? Text(
                      "Dark Mode",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      "Light Mode",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
              Switch(
                  value: isDark,
                  onChanged: (value) {
                    setState(() {
                      isDark = value;
                    });
                    print(isDark);
                  })
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Home"),
          bottom: PreferredSize(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                    margin: EdgeInsets.only(right: 20),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        )))
              ]),
              preferredSize: Size.fromHeight(30)),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snap) {
              return Center(
                child: LiquidPullToRefresh(
                  onRefresh: _handleRequest,
                  color: Colors.amber,
                  child: ListView.builder(itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1674574124340-c00cc2dae99c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwzMXx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${snap.data?[index].user.name}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12, bottom: 5),
                          child: ReadMoreText(
                            "Google's service, offered free of charge, instantly translates words, phrases, and web pages between English and over 100 other languages. Google's service, offered free of charge, instantly translates words, phrases, and web pages between English and over 100 other languages.",
                            trimLines: 3,
                            colorClickableText: isDark
                                ? Color.fromARGB(255, 255, 205, 56)
                                : Color.fromARGB(255, 85, 84, 89),
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'show more',
                            trimExpandedText: ' ...show less',
                            moreStyle: TextStyle(fontSize: 17),
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        FullScreenWidget(
                          backgroundIsTransparent: true,
                          disposeLevel: DisposeLevel.Low,
                          child: Container(
                            child: Image.network(
                                "https://images.unsplash.com/photo-1688750771915-64047b2aad5a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0M3x8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              );
            }),
      ),
    );
  }
}
