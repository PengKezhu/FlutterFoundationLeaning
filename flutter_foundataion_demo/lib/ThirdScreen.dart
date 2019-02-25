import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'FourthScreen.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }
}

class ThirdScreen extends StatelessWidget {
  Future<Post> _getData() async {
    final response =
        await Dio().get('http://jsonplaceholder.typicode.com/posts/1', options: Options(headers: {'token' : ''}));
 final responseJson = json.decode(response.toString());
    return Post.fromJson(responseJson);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThirdScreen',
      home: Scaffold(
        appBar: AppBar(
            title: GestureDetector(
              child: const Text('Network Request Screen'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FourthScreen();
                }));
              },
            ),
            leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: () => Navigator.pop(context),
            )),
        body: FutureBuilder<Post> (
          future: _getData(),
          builder: (buildContext, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Text('post model: \n' + snapshot.data.title + '\n' + snapshot.data.body),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: Text('loading'),
              );
            }
          },
        ),
      ),
    );
  }
}
