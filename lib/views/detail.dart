import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {
  // 传递参数
  MovieDetail({Key key, @required this.id, @required this.movieTitle}): super(key: key);
  final String id;
  final String movieTitle;

  @override
  _MovieDetailState createState() {
    return _MovieDetailState();
  }
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    // return Text('详情页--${widget.movieTitle}');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieTitle),
        centerTitle: true,
      ),
      body: Text(widget.movieTitle)
    );
  }
}