import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

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
      home: new ShoppingList(
        products: <Product>[
          new Product(name: 'fish'),
          new Product(name: 'milk'),
          new Product(name: 'bread'),
        ],
      ),
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
  Set<Product> _shoppingCart = new Set<Product>();
  int selectedIndex = 0;
  bool checked = false;
  String radioSelectedValue = '1';
  bool switchOn = true;
  double sliderValue = 0.3;
  int expandPanelHeaderSelectIndex = -1;

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

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: choices.length,
      child: new Scaffold(
        appBar: AppBar(
            title: Text("Tabbar"),
            bottom: TabBar(
              tabs: choices.map((Choice choice) {
                return Tab(
                  text: choice.title,
                  icon: choice.icon,
                );
              }).toList(),
            )),
        body: TabBarView(
          children: choices.map((Choice choice) {
            return Center(
              child: Text(choice.title),
            );
          }).toList(),
        ),
        drawer: Drawer(
          child: Container(
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

                    showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
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
                              child: FlatButton(child: const Text('header0'), onPressed: (){
                                  setState(() {
                                    expandPanelHeaderSelectIndex = 0;
                                  });
                              },),
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
                              child: FlatButton(child: const Text('header1'), onPressed: (){
                                  setState(() {
                                    expandPanelHeaderSelectIndex = 1;
                                  });
                              },),
                            ),
                          );
                        },
                        body: const Text('body1'),
                      )
                    ],
                  ),
                )
              ],
            )),
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
