import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;

  List<Photo> _photos = [];
  String url = "https://jsonplaceholder.typicode.com/photos";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Http demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () async {
              setState(() {});
              isLoading = true;
              var response = await http.get(url);
              Iterable it = json.decode(response.body);
              _photos = it.map((e) => Photo.fromJson(e)).toList();
              isLoading = false;
              setState(() {});
            },
            child: Text("Load Data"),
          ),
          if (isLoading) CircularProgressIndicator(),
          Expanded(
            child: ListView.builder(
              itemCount: _photos.length,
              itemBuilder: (context, index) => Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    children: [
                      Center(child: Text(_photos[index].title)),
                      SizedBox(
                        height: 10,
                      ),
                      Image.network(
                        _photos[index].url,
                        height: 100,
                        width: double.maxFinite,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Photo {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  Photo.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}
