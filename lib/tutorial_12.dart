import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product {
  final int id;
  final String name;
  final int price;

  const Product({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'] ?? 0,
    );
  }
}

void main() {
  runApp(const Tutorial12App());
}

class Tutorial12App extends StatelessWidget {
  const Tutorial12App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Tutorial12(),
    );
  }
}

class Tutorial12 extends StatefulWidget {
  const Tutorial12({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Tutorial12State createState() => _Tutorial12State();
}

class _Tutorial12State extends State<Tutorial12> {
  List<dynamic> products = []; // List untuk menampung data produk

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // Fungsi untuk mengambil data dari API
  Future<void> fetchData() async {
  try {
    var response = await http.get(Uri.parse('http://192.168.1.34:8000/api/product'));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      //print(response.body);
      if (responseData != null && responseData['list'] != null) {
        setState(() {
          products = responseData['list'];
        });
      } else {
        throw Exception('Data not found in response');
      }
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    throw ('Error fetching data: $e');
  }
}

  Future<void> addProduct(String name, int price) async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.1.34:8000/api/product'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'price': price}),
      );
      //print(response.statusCode);
      //print(response.body);

      if (response.statusCode == 200) {
        fetchData();
      } else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      throw('Error adding product: $e');
    }
  }
  
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorial 12'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index]['name']),
            subtitle: Text(products[index]['price'].toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context, 
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Product'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                    )
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    }, 
                    child: const Text('Cancel'),
                  ),
                    TextButton(
                    onPressed: () {
                      final String name = nameController.text;
                      final String priceText = priceController.text;

                      if (name.isEmpty || priceText.isEmpty) {
                        _showErrorDialog('Both fields are required.');
                        return;
                      }

                      final int price = int.parse(priceText);
                      addProduct(name, price);

                      Navigator.of(context).pop();
                    },

                      child: const Text('Save'),
                    )
                  ]
                );
            }
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
