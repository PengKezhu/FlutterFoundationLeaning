import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'ThirdScreen.dart';

class SecondScreen extends StatefulWidget {
  final String title;
  SecondScreen({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SecondScreenState();
  }
}

class SecondScreenState extends State<SecondScreen> {
  List _items = ['网络请求'];

  void _handleTap(String item) {
    // Navigator.pop(context, item);
    print('object');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ThirdScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecondScreen',
      home: Scaffold(
        appBar: AppBar(
            title: widget.title != null ? Text(widget.title) : Text('no title specified'),
            leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: () => Navigator.pop(context),
            )),
        body: Container(
          child: ListView(
            children: _items
                .map((item) => Dismissible(
                      crossAxisEndOffset: 100.0,
                      background: Container(
                        child: Center(
                          child: const Text(
                            '删除',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                        color: Colors.red,
                      ),
                      onDismissed: (DismissDirection direction) {
                        if (direction == DismissDirection.endToStart) {
                          setState(() {
                            _items.remove(item);
                          });
                        }
                      },
                      key: Key(item),
                      child: ListTile(
                        title: GestureDetector(
                          child: Text(item),
                          onTap: () => _handleTap(item),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
