import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/Cupertino.dart';

class FourthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FourthScreenState();
  }
}

class FourthScreenState extends State<FourthScreen>
    with TickerProviderStateMixin {
  IOWebSocketChannel _channel =
      IOWebSocketChannel.connect('ws://echo.websocket.org');
  TextEditingController _controller = TextEditingController();

  AnimationController animationController;
  CurvedAnimation animation;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('WebSocket Screen'),
            leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: () => Navigator.pop(context),
            )),
        body: Container(
          // color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Form(
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: 'input a message'),
                ),
              ),
              // TextField(
              //   controller: _controller,
              //   // style: TextStyle(color: Colors.white),
              //   decoration: InputDecoration(
              //       fillColor: Colors.black, labelText: 'input message'),
              // ),
              StreamBuilder(
                  stream: _channel.stream,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Text('received message:  ' +
                          (snapshot.hasData ? snapshot.data : '')),
                    );
                  }),
              RaisedButton(
                child: Text('Send'),
                onPressed: () {
                  _channel.sink.add(_controller.text);
                },
              ),
              Container(
                margin: EdgeInsets.all(30),
                child: CupertinoButton(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.blue,
                  pressedOpacity: 0.7,
                  child: const Text('Fade Animation Start'),
                  onPressed: () {
                    print('object');
                    animationController.forward();
                  },
                ),
              ),
              Container(
                  child: FadeTransition(
                      opacity: animation, child: FlutterLogo(size: 50))),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child:
                      Opacity(child: Text('0.5 Opacity Widget'), opacity: 0.5)),
              CustomButton(title: 'CustomButton')
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final title;
  CustomButton({this.title});
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(child: Text(title), onPressed: () {});
  }
}
