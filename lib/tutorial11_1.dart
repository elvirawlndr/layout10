import 'package:flutter/material.dart';
import 'tutorial11_2.dart';

class Tutorial11_1Page extends StatelessWidget {
  const Tutorial11_1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tutorial 11-1'),
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.email), text: 'Email'),
              Tab(icon: Icon(Icons.person), text: 'About'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Tutorial11_2Page(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Halo, ini elvira', style: TextStyle(fontSize: 24)),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  child: const Text('Go to Home page'),
              ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
