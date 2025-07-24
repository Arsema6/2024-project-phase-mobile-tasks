import 'package:flutter/material.dart';
import 'login.dart';
import 'search.dart';
import 'home.dart';
import 'addProduct.dart';
import 'description.dart';

void main() {
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(userName: 'User'),
        '/add': (context) => const AddProductPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => DescriptionPage(
              image: args['image'],
              name: args['name'],
              price: args['price'],
              rating: args['rating'],
              category: args['category'],
              desc: args['desc'],
              sizes: args['sizes'],
            ),
          );
        }
        if (settings.name == '/search') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => SearchPage(products: args['products']),
          );
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}