import 'dart:convert';

import 'package:flu_lara_product_api/add_product.dart';
import 'package:flu_lara_product_api/product_details.dart';
import 'package:flu_lara_product_api/screen/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = "http://192.168.0.101/lara_product_api/public/api/products";

  Future getProduct() async {
    var response =
        await http.get(Uri.parse(url), headers: {"Accept": 'application/json'});

    var jsonData = json.decode(response.body);
    //print(jsonData);
    return jsonData;

    // print(jsonData);
  }

  Future deleteProduct(String productId) async {
    String url = "http://192.168.0.101/lara_product_api/public/api/products/ " +
        productId;
    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    //  getProduct();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProduct()));
            },
            child: Icon(Icons.add)),
        appBar: AppBar(title: Text('rotio store')),
        body: FutureBuilder(
            future: getProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetail(
                                          product: snapshot.data['data']
                                              [index])));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.blue),
                                padding: EdgeInsets.all(5),
                                height: 120,
                                width: 120,
                                child: Image.network(
                                    snapshot.data['data'][index]['image_url'],
                                    fit: BoxFit.cover)),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          snapshot.data['data'][index]['name'],
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold))),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(snapshot.data['data'][index]
                                          ['description'])),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data['data'][index]
                                          ['price']),
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProduct(
                                                          product: snapshot
                                                                  .data['data']
                                                              [index],
                                                        )));
                                          },
                                          child: Icon(Icons.edit)),
                                      GestureDetector(
                                          onTap: () {
                                            deleteProduct(snapshot.data['data']
                                                        [index]['id']
                                                    .toString())
                                                .then((value) {
                                                  setState(() {});
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Product well deleted')));
                                            });
                                          },
                                          child: Icon(Icons.delete))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    });
              } else {
                return Text('no data');
              }
            }));
  }
}
