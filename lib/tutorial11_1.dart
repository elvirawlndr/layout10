import 'package:flutter/material.dart';

class Tutorial11_1Page extends StatelessWidget {
  const Tutorial11_1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorial 11-1'),
      ),
      body: Center(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Text('Halo, ini elvira'),
          ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text('Go to Home page'),
          ),
        ],
        ),
      ),
    );
  }
}