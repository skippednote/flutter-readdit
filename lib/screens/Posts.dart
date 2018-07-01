import "package:flutter/material.dart";
import "./Post.dart";

class Posts extends StatefulWidget {
  final List posts;
  final String sub;

  Posts({Key key, this.posts, this.sub}) : super(key: key);
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.sub}"),
      ),
      body: ListView.builder(
          itemCount: this.widget.posts.length,
          itemBuilder: (BuildContext context, int index) =>
              _postItem(context, index)),
    );
  }

  _postItem(BuildContext context, int index) {
    return ListTile(
      onTap: () => _openPost(this.widget.posts[index]['data']),
      title: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(5.0)),
        child: Column(
          children: <Widget>[
            Row(children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(this.widget.posts[index]['data']['title']),
              )),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.arrow_drop_up,
                    color: Colors.green,
                  ),
                  Text(this.widget.posts[index]['data']['ups'].toString())
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.red,
                  ),
                  Text(this.widget.posts[index]['data']['downs'].toString())
                ],
              )
            ])
          ],
        ),
      ),
    );
  }

  _openPost(post) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Post(post: post),
        ));
  }
}
