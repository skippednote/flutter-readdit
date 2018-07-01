import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'dart:convert';
import "./Posts.dart";

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Readdit"),
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            decoration: InputDecoration(labelText: "Sub-reddit"),
            onSubmitted: (String sub) => _submitHandler(context, sub),
          ),
        );
      }),
    );
  }

  _submitHandler(BuildContext context, String sub) async {
    if (sub.length == 0) {
      SnackBar snackbar =
          _createSnack("Enter a sub", Icons.warning, Colors.red);
      Scaffold.of(context).showSnackBar(snackbar);
      return;
    }
    SnackBar snackbar = _createSnack("Loading $sub", Icons.web, Colors.teal);
    Scaffold.of(context).showSnackBar(snackbar);
    try {
      var response = await http.get("https://www.reddit.com/r/$sub.json");
      var json = JSON.decode(response.body);
      var posts = json["data"]["children"];
      if (posts.length == 0) {
        throw Error();
      } else {
        Scaffold.of(context).hideCurrentSnackBar();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Posts(posts: posts, sub: sub)));
      }
    } catch (e) {
      SnackBar snackbar =
          _createSnack("Failed to load $sub", Icons.warning, Colors.red);
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  SnackBar _createSnack(String message, IconData icon, MaterialColor color) {
    SnackBar snackbar = SnackBar(
        backgroundColor: color,
        content: Row(
          children: <Widget>[
            Icon(icon),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(message),
            ),
          ],
        ));
    return snackbar;
  }
}
