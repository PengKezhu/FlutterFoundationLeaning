import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/Cupertino.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class SixthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SixthScreenState();
  }
}

class SixthScreenState extends State {
  File pickedImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SixthScreen'),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              CupertinoButton(
                child: const Text('show image picker'),
                onPressed: () async {
                  var image =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    pickedImage = image;
                  });
                },
              ),
              pickedImage != null ? Image.file(pickedImage) : Text('null'),
              CupertinoButton(
                child: Text('shared_preference'),
                onPressed: () async {
                  SharedPreferences userDefaults =
                      await SharedPreferences.getInstance();
                  userDefaults.setBool('isFlutter', true);
                  var isFlutter = userDefaults.getBool('isFlutter');
                  print('isFlutter: + $isFlutter');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
