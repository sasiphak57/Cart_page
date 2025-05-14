import 'package:flutter/material.dart';
import 'screens/cart_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cart App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Arial',
      ),
      home: const CartScreen(),
    );
  }
}
