import 'dart:convert';
import 'package:flu_lara_product_api/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
  final Map product;
  EditProduct({@required this.product});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();
  Future updateProduct() async {
    final response = await http.put(
        Uri.parse("http://192.168.0.101/lara_product_api/public/api/products/" +
            product['id'].toString()),
        body: {
          'name': _nameController.text,
          'description': _descriptionController.text,
          'price': _priceController.text,
          'image_url': _imageUrlController.text
        });
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController..text = product['name'],
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController
                  ..text = product['description'],
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController..text = product['price'],
                decoration: InputDecoration(labelText: "Price"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController..text = product['image_url'],
                decoration: InputDecoration(labelText: "image url"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product image url';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      updateProduct().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Product well edited')));
                      });
                    }
                  },
                  child: Text('update'))
            ],
          ),
        ));
  }
}
