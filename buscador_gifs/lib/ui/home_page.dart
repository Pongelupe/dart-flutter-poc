import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

final String API_SEARCH_TRENDING =
    "https://api.giphy.com/v1/gifs/trending?api_key=1ZB3Ij9JFHoSw9u9E3PAONukXnruGIbS&limit=25&rating=G";
final API_SEARCH_SEARCH = (String search, int offset) =>
    "https://api.giphy.com/v1/gifs/search?api_key=1ZB3Ij9JFHoSw9u9E3PAONukXnruGIbS&q=$search&limit=25&offset=$offset&rating=G&lang=en";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset;

  Future<Map> _getGifs() async {
    http.Response response;

    if (_search == null) {
      response = await http.get(API_SEARCH_TRENDING);
    } else {
      response = await http.get(API_SEARCH_SEARCH(_search, _offset));
    }

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Pesquise Aqui",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
