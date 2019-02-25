import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'SecondScreen.dart';
import 'ThirdScreen.dart';
import 'FourthScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget _shopListWidget () {
    return new ShoppingList(
        products: <Product>[
          new Product(name: 'fish'),
          new Product(name: 'milk'),
          new Product(name: 'bread'),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    // debugPaintPointersEnabled = true;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: _shopListWidget(),
      routes: <String, WidgetBuilder> {
        '/a' : (context)=>SecondScreen(),
        '/b' : (context)=>ThirdScreen(),
        '/c' : (context)=>FourthScreen(),
      },
    );
  }
}

class MyScafford extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: <Widget>[
          new MyAppBar(
            title: new Container(
                child: new Text('MyAppBar',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white))),
          ),
          new Expanded(
            child: new Center(
              child: new MyButton(),
            ),
          )
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        print('MyButton tapped');
      },
      child: new Container(
          height: 36.0,
          padding: new EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(5.0),
              color: Colors.lightGreen),
          child: new Container(
              color: Colors.red,
              child: new Center(
                child: new Text('BUTTON'),
              ))),
    );
  }
}

/**
 *  new Center(
            child: new Text('BUTTON'),
          )
 * 
 */

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 88.0,
        decoration: new BoxDecoration(color: Colors.blue[500]),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new SizedBox(
              height: 44.0,
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new IconButton(
                      icon: new Icon(Icons.menu, color: Colors.white),
                      onPressed: null),
                  new Expanded(
                    child: title,
                  ),
                  new IconButton(
                    icon: new Icon(Icons.search, color: Colors.white),
                    onPressed: null,
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class Product {
  const Product({this.name});
  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShopItem extends StatelessWidget {
  ShopItem({Product product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: new ObjectKey(product));

  final CartChangedCallback onCartChanged;
  final bool inCart;
  final Product product;

  TextStyle _getTextStyle() {
    if (!inCart) return null;
    return new TextStyle(
        color: Colors.black54, decoration: TextDecoration.lineThrough);
  }

  Color _getBackgroundColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getBackgroundColor(context),
        child: new Text(product.name[0]),
      ),
      title: new Text(
        product.name,
        style: _getTextStyle(),
      ),
    );
  }
}

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products, this.choices}) : super(key: key);

  final List<Product> products;
  final List<Choice> choices;

  @override
  State<StatefulWidget> createState() {
    return new ShoppingListState();
  }
}

class ShoppingListState extends State<ShoppingList> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  Set<Product> _shoppingCart = new Set<Product>();
  int selectedIndex = 0;
  bool checked = false;
  String radioSelectedValue = '1';
  bool switchOn = true;
  double sliderValue = 0.3;
  int expandPanelHeaderSelectIndex = -1;
  var networkPictureSrc =
      'https://github.com/flutter/plugins/raw/master/packages/video_player/doc/demo_ipod.gif?raw=true';
  var _currentStep = 0;

  void _onCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  Widget _listView() {
    Widget list = new ListView(
      children: widget.products.map((Product product) {
        return new ShopItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _onCartChanged);
      }).toList(),
    );
    return list;
  }

  Widget _raisedButton() {
    Widget button = new RaisedButton(
      color: Colors.blue,
      textColor: Colors.white,
      child: new Text("BUTTON"),
      padding: new EdgeInsets.all(10.0),
      onPressed: () {
        print('object');
      },
    );
    return button;
  }

  Widget _flutterLogo() {
    return new FlutterLogo(
      style: FlutterLogoStyle.stacked,
    );
  }

  Widget _placeholder() {
    return new SizedBox(
      width: 100,
      height: 100,
      child: new Placeholder(
        color: Colors.grey,
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return new Scaffold(
  //     appBar: new AppBar(title: new Text('ShopCart')),
  //     body: new Center(
  //       child: new TabBar(tabs: <Widget>[new Text('1')], controller: new TabController(length: 1, vsync: TickerProvider()),),
  //     ),
  //     bottomNavigationBar: BottomNavigationBar(
  //       items: <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(title: Text('Contact'), icon: Icon(Icons.contact_phone)),
  //         BottomNavigationBarItem(title: Text('Email'), icon: Icon(Icons.contact_mail)),
  //       ],
  //       onTap: (int idx) {
  //         setState(() {
  //           selectedIndex = idx;
  //         });
  //       },
  //       currentIndex: selectedIndex,
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       child: Icon(Icons.add),
  //     ),
  //     floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  //   );
  // }

  List<Choice> choices = [
    Choice(title: 'Cake', icon: Icon(Icons.cake)),
    Choice(title: 'Face', icon: Icon(Icons.face)),
    Choice(title: 'Place', icon: Icon(Icons.place)),
  ];

  TabBarView _createTabbarView() {
    return TabBarView(
      children: choices.map((Choice choice) {
        return Center(
          child: Text(choice.title),
        );
      }).toList(),
    );
  }

  ListView _createLongListView() {
    var _list = List<String>.generate(10000, (i) => 'Item $i');

    return ListView.builder(
      itemCount: 10000,
      itemBuilder: (BuildContext context, int i) {
        return i % 6 == 0
            ? ListTile(
                title: Text(
                _list[i],
                style: TextStyle(color: Colors.red),
              ))
            : ListTile(
                title: Text(
                _list[i],
                style: TextStyle(color: Colors.green),
              ));
      },
    );
  }

  GridView _createGridView() {
    return GridView.count(
        crossAxisCount: 2,
        children: new List.generate(100, (int index) {
          return Container(
            child: Center(
              child: Text(
                '$index',
                style: TextStyle(color: Colors.white, fontSize: 27),
              ),
            ),
            color: Colors.primaries[index % 16],
          );
        }));
  }

  InkWell _createInkWell() {
    return InkWell(
      highlightColor: Colors.red,
      splashColor: Colors.green,
      onTap: () {},
      child: Container(
        height: 100,
        width: 100,
        padding: EdgeInsets.all(8),
        child: Center(
          child: const Text('InkWellButton'),
        ),
      ),
    );
  }

  Widget _createDrawerContent() {
    return Container(
      child: Center(
          child: ListView(
        children: <Widget>[
          Text(
            'I am drawer',
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text('FlatButton'),
            onPressed: () {},
            color: Colors.blue,
          ),
          IconButton(
            icon: Icon(Icons.today),
            onPressed: () {},
          ),
          PopupMenuButton(
            onSelected: (widget) {
              print('widget');
            },
            onCanceled: () {
              print('Canceled');
            },
            itemBuilder: (BuildContext build) {
              return [
                PopupMenuItem(
                  child: Text('one'),
                ),
                PopupMenuItem(
                  child: Text('two'),
                ),
                PopupMenuItem(
                  child: Text('three'),
                ),
              ];
            },
          ),
          ButtonBar(
            children: <Widget>[Text('1'), Text('2'), Text('3')],
            alignment: MainAxisAlignment.center,
          ),
          TextField(
            maxLines: null,
            maxLength: TextField.noMaxLength,
            maxLengthEnforced: true,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.grey, fontSize: 17),
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.book),
                suffixIcon: Icon(Icons.book),
                border: InputBorder.none),
          ),
          Checkbox(
            value: checked,
            onChanged: (bool boxChecked) {
              setState(() {
                checked = boxChecked;
              });
            },
          ),
          Radio(
            value: '1',
            groupValue: radioSelectedValue,
            onChanged: (String newValue) {
              setState(() {
                radioSelectedValue = newValue;
              });
            },
          ),
          Radio(
            value: '2',
            groupValue: radioSelectedValue,
            onChanged: (String newValue) {
              setState(() {
                radioSelectedValue = newValue;
              });
            },
          ),
          Radio(
            value: '3',
            groupValue: radioSelectedValue,
            onChanged: (String newValue) {
              setState(() {
                radioSelectedValue = newValue;
              });
            },
          ),
          Center(
            child: Switch(
              value: switchOn,
              onChanged: (bool newValue) {
                setState(() {
                  switchOn = newValue;
                });
              },
            ),
          ),
          Slider(
            value: sliderValue,
            onChanged: (double newValue) {
              setState(() {
                sliderValue = newValue;
              });
            },
            activeColor: Colors.red,
            inactiveColor: Colors.grey,
          ),
          RaisedButton(
            child: Text('showTimePicker'),
            onPressed: () {
              // showDatePicker(
              //     firstDate: DateTime(2017),
              //     initialDate: DateTime(2018, 08, 03),
              //     lastDate: DateTime.now(),
              //     context: context);

              showTimePicker(context: context, initialTime: TimeOfDay.now());
            },
          ),
          SimpleDialog(
            title: Text('title'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text('OK'),
              )
            ],
          ),
          RaisedButton(
            child: const Text('showDialog'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AboutDialog();
                  });
            },
          ),
          AlertDialog(
            title: const Text('Alert'),
            content: Center(
              child: TextField(),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
          RaisedButton(
            child: const Text('showBottomSheet'),
            onPressed: () {
              showModalBottomSheet(
                  builder: (BuildContext context) {
                    return ListView(
                      children: <Widget>[
                        const Text('1'),
                        const Text('2'),
                        const Text('3'),
                      ],
                    );
                  },
                  context: context);
            },
          ),
          Container(
            child: ExpansionPanelList(
              children: [
                ExpansionPanel(
                  isExpanded: expandPanelHeaderSelectIndex == 0,
                  headerBuilder: (BuildContext context, bool expanded) {
                    return GestureDetector(
                      child: Container(
                        child: FlatButton(
                          child: const Text('header0'),
                          onPressed: () {
                            setState(() {
                              expandPanelHeaderSelectIndex = 0;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  body: const Text('body0'),
                ),
                ExpansionPanel(
                  isExpanded: expandPanelHeaderSelectIndex == 1,
                  headerBuilder: (BuildContext context, bool expanded) {
                    return GestureDetector(
                      child: Container(
                        child: FlatButton(
                          child: const Text('header1'),
                          onPressed: () {
                            setState(() {
                              expandPanelHeaderSelectIndex = 1;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  body: const Text('body1'),
                )
              ],
            ),
          ),
          SizedBox(
            height: 100,
            width: 200,
            child: Image.network(networkPictureSrc,
                width: 50, height: 25, fit: BoxFit.contain),
          ),
          // SizedBox(
          //     height: 100,
          //     width: 200,
          //     child: CachedNetworkImage(
          //       placeholder: Image.asset('images/timg.jpeg'),
          //       imageUrl: networkPictureSrc,
          //     )),
          Icon(Icons.ac_unit),
          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: Text('AB'),
            ),
            label: Text('Aaron Burr'),
            deleteIcon: Icon(Icons.delete),
            deleteIconColor: Colors.black,
          ),
          InputChip(
            avatar: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: Text('AB'),
            ),
            label: Text('InputChip'),
            onPressed: () {},
            deleteIcon: Icon(Icons.delete),
            deleteIconColor: Colors.black,
          ),
          ChoiceChip(
            selected: true,
            label: Text('ChoiceChip'),
            onSelected: (bool newValue) {
              print(newValue);
            },
          ),
          ActionChip(
            label: Text('ChoiceChip'),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.desktop_mac),
            onPressed: () {},
            tooltip: 'Tooltip()',
          ),
          DataTable(
            columns: [
              DataColumn(label: Text('column0')),
              DataColumn(label: Text('column1')),
              DataColumn(label: Text('column2'))
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('cell00')),
                DataCell(Text('cell01')),
                DataCell(Text('cell02'))
              ]),
              DataRow(cells: [
                DataCell(Text('cell10')),
                DataCell(Text('cell11')),
                DataCell(Text('cell12'))
              ]),
              DataRow(cells: [
                DataCell(Text('cell20')),
                DataCell(Text('cell21')),
                DataCell(Text('cell22'))
              ]),
            ],
          ),
          Card(
            child: SizedBox(
              width: 200,
              height: 200,
              child: CircleAvatar(
                backgroundColor: Colors.green,
              ),
            ),
          ),
          LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey,
          ),
          ListTile(
            leading: const Text('leading'),
            title: const Text('title'),
            subtitle: const Text('sub title'),
            trailing: Icon(Icons.adb),
          ),
          Stepper(
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      print('onStepCancel');
                    },
                  ),
                  FlatButton(
                    child: const Text('Continue'),
                    onPressed: () {
                      print('onStepContinue');
                    },
                  ),
                ],
              );
            },
            onStepCancel: () {
              print('onStepCancel');
            },
            onStepContinue: () {
              setState(() {
                _currentStep++;
              });
              print('onStepContinue');
            },
            currentStep: _currentStep,
            onStepTapped: (int stepIndex) {
              setState(() {
                _currentStep = stepIndex;
              });
            },
            steps: <Step>[
              Step(
                  title: Text('step1 title'),
                  subtitle: Text('step1 subTitle'),
                  content: Text('step content 1')),
              Step(title: Text('step2'), content: Text('step content 2')),
              Step(title: Text('step3'), content: Text('step content 3')),
              Step(title: Text('step4'), content: Text('step content 4')),
            ],
          ),
          Divider(
            indent: 50,
          ),
          SizedBox(
            child: Container(
              color: Colors.grey,
            ),
            height: 100,
            width: 100,
          ),
          Divider(
            indent: 50,
          ),
          InkWell(
            highlightColor: Colors.red,
            splashColor: Colors.green,
            onTap: () {},
            child: Container(
              constraints: BoxConstraints.tight(Size(40, 20)),
              child: Center(
                child: const Text('InkWellButton'),
              ),
            ),
          ),
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: choices.length,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: GestureDetector(
                child: Text("Tabbar"),
                onTap: () async {
                  final result = await Navigator.pushNamed(context, '/a');
                  print(result);
                  // _scaffoldKey.currentState.showSnackBar(SnackBar(
                  //   content: Text('Message'),
                  //   duration: Duration(milliseconds: 500),
                  // ));
                }),
            bottom: TabBar(
              tabs: choices.map((Choice choice) {
                return Tab(
                  text: choice.title,
                  icon: choice.icon,
                );
              }).toList(),
            )),
        body: _createGridView(),
        drawer: Drawer(
          child: Container(
            child: _createInkWell(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final Icon icon;
}
