import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  const ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData _product;

  String size;

  _ProductScreenState(this._product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme
        .of(context)
        .primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(_product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
              aspectRatio: 0.9,
              child: Carousel(
                images:
                _product.images.map((url) => NetworkImage(url)).toList(),
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: false,
              )),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  _product.title,
                  maxLines: 3,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  "R\$ ${_product.price.toStringAsFixed(2).replaceAll(
                      ".", ",")}",
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Tamanho",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.5,
                      ),
                      children: _product.sizes
                          .map((size) =>
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                this.size = size;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4.0)),
                                  border: Border.all(
                                      color: this.size == size
                                          ? primaryColor
                                          : Colors.grey[500],
                                      width: 3.0)),
                              width: 50.0,
                              alignment: Alignment.center,
                              child: Text(size),
                            ),
                          ))
                          .toList()),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: size != null
                        ? () {
                      if (UserModel.of(context).isLoggedIn()) {
                        CartProduct cartProduct = CartProduct();
                        cartProduct.size = size;
                        cartProduct.quantity = 1;
                        cartProduct.pid = _product.id;
                        cartProduct.category = _product.category;


                        CartModel.of(context).addCartItem(cartProduct);
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      }
                    }
                        : null,
                    child: Text(UserModel.of(context).isLoggedIn() ?
                    "Adicionar ao Carrinho" : "Entre para comprar",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Descrição",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  _product.description,
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
