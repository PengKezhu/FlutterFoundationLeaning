import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/Cupertino.dart';
import 'FifthScreen.dart';
import 'package:location/location.dart';

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
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    _getLocation();
  }

  void _getLocation() async {
    var location = await Location().getLocation();
    var latitude = location.latitude;
    var longitude = location.longitude;
    var accuracy = location.accuracy;

    print('$latitude' + '\n' + '$longitude' + '\n' + '$accuracy');
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
                  decoration: InputDecoration(hintText: 'input a message'),
                  onFieldSubmitted: (string) {
                    print('submitted string: $string');
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'placeHolder', errorText: 'error'),
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
              CustomButton(
                title: 'CustomButton',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FifthScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final title;
  final VoidCallback onPressed;
  CustomButton({this.title, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        child: Text(title),
        onPressed: this.onPressed != null ? this.onPressed : () {});
  }
}
