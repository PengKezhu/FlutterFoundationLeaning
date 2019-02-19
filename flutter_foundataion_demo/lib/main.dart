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
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  @override
  State<StatefulWidget> createState() {
    return new ShoppingListState();
  }
}

class ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = new Set<Product>();

  void _onCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text('ShopCart')),
        body: new ListView(
          children: widget.products.map((Product product) {
            return new ShopItem(
                product: product,
                inCart: _shoppingCart.contains(product),
                onCartChanged: _onCartChanged);
          }).toList(),
        ));
  }
}
