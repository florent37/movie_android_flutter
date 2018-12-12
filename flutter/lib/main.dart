import 'package:flutter/material.dart';
import 'package:mvvm_sample/search/SearchPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          
        ),
        home: Scaffold(
            body: SafeArea(child: SearchPage())));
  }
}
