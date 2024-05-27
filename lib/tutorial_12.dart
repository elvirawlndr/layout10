import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Tutorial12 extends StatefulWidget {
  const Tutorial12({super.key});

  @override
  _Tutorial12State createState() => _Tutorial12State();
}

class _Tutorial12State extends State<Tutorial12> {
  List<dynamic> products = []; // List untuk menampung data produk

  // Fungsi untuk mengambil data dari API
  Future<void> fetchData() async {
  try {
    var response = await http.get(Uri.parse('http://192.168.1.45:8000/api/product'));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(response.body);
      if (responseData != null && responseData['list'] != null) {
        setState(() {
          // Mengambil data produk dari kunci 'products'
          products = responseData['list'];
        });
      } else {
        throw Exception('Data not found in response');
      }
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }

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
            // Tambahkan aksi lainnya sesuai kebutuhan
          );
        },
      ),
    );
  }
}
