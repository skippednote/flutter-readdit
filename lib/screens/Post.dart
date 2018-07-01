import "package:flutter/material.dart";
import "package:transparent_image/transparent_image.dart";

class Post extends StatefulWidget {
  final post;

  Post({Key key, this.post}) : super(key: key);
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.post["title"]),
      ),
      body: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  this.widget.post["title"],
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
          Expanded(
              child: this.widget.post["preview"] != null
                  ? FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: this.widget.post["preview"]["images"][0]["source"]
                          ["url"],
                      fit: BoxFit.fill,
                    )
                  : Container())
        ],
      ),
    );
  }
}
