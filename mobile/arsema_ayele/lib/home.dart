import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'addProduct.dart';
import 'description.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search.dart';
import 'product.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List, XFile;
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  final String userName;
  final bool hasNewMessages;
  const MyHomePage({super.key, required this.userName, this.hasNewMessages = false});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> products = [
    {
      'image': 'assets/shoe4.jpg',
      'name': 'Buckle leather shoes',
      'price': '\$45.99',
      'rating': 4.5,
      'category': 'Women Shoe',
      'sizes': [38,39, 40, 41, 42],
      'desc': '''100% bovine leather. Round toe. Decorative buckle. Block heel. 3 cm heel. No Fastening. Inner lining.

A selection of refined garments, made with quality materials to create a feminine and contemporary wardrobe

REF. 87053286''',
      'isAsset': true,
    },
    {
      'image': 'assets/shoe3.png',
      'name': 'Nike P-600',
      'price': '\$125',
      'rating': 4.2,
      'category': 'Men Shoe',
      'sizes': [41, 42, 43, 44], 
      'desc': 'A mash-up of past Pegasus sneakers, the Nike P-6000 takes early 2000s running style to modern heights. Combining sporty lines with breathable textiles and lifted foam cushioning, it\'s the perfect mix of head-turning looks and unbelievable comfort.',
      'isAsset': true,
    },
  ];

  // Add product from AddProductPage
  Future<void> _navigateToAddProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddProductPage()),
    );
    if (result != null && result is Product) {
      setState(() {
        products.add({
          'image': result.image,
          'name': result.name,
          'price': '\$${result.price}',
          'rating': 5.0, // Default rating for new products
          'category': result.category,
          'desc': result.desc,
          'sizes': result.sizes, 
          'isAsset': false,
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully')),
      );
    }
  }

  Widget _buildProductCard({required int index, required Map<String, dynamic> product}) {
    Widget imageWidget;
    if (product['isAsset'] == true) {
      imageWidget = Image.asset(
        product['image'] as String,
        width: 366,
        height: 160,
        fit: BoxFit.cover,
        alignment: Alignment.bottomCenter,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 366,
          height: 160,
          color: Colors.grey[200],
          child: const Icon(Icons.image, size: 40, color: Colors.grey),
        ),
      );
    } else if (kIsWeb && product['image'] is Uint8List) {
      imageWidget = Image.memory(
        product['image'] as Uint8List,
        width: 366,
        height: 160,
        fit: BoxFit.cover,
        alignment: Alignment.bottomCenter,
      );
    } else if (product['image'] is XFile) {
      imageWidget = Image.file(
        File((product['image'] as XFile).path),
        width: 366,
        height: 160,
        fit: BoxFit.cover,
        alignment: Alignment.bottomCenter,
      );
    } else {
      imageWidget = Container(
        width: 366,
        height: 160,
        color: Colors.grey[200],
        child: const Icon(Icons.image, size: 40, color: Colors.grey),
      );
    }
    return InkWell(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DescriptionPage(
              image: product['image'],
              name: product['name'],
              price: product['price'],
              rating: product['rating'],
              category: product['category'],
              desc: product['desc'] ?? '',
              sizes: product['sizes'] ?? [],
            ),
          ),
        );
        if (result == 'delete') {
          setState(() {
            products.removeAt(index);
          });
        } else if (result is Map && result['action'] == 'update' && result['product'] != null) {
          setState(() {
            products[index] = result['product'];
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Updated successfully')),
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 366,
                height: 160,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: imageWidget,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      product['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    product['price'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    product['category'],
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 3),
                  Text(
                    '(${(product['rating'] as double).toStringAsFixed(1)})',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String today = DateFormat('MMMM d, yyyy').format(DateTime.now());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row with responsive notification icon
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 0, top: 44, bottom: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile picture
                        Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        // Greeting and date
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                today,
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(fontSize: 16, color: Colors.black),
                                  children: [
                                    const TextSpan(text: 'Hello, '),
                                    TextSpan(
                                      text: widget.userName,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Notification icon (responsive, like search icon)
                        Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(width: 1, color: Colors.grey.shade300),
                          ),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.notifications_none, color: Colors.grey),
                                onPressed: () {},
                                splashRadius: 20,
                              ),
                              if (widget.hasNewMessages)
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Second row: Available Products and search icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Available Products',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1, color: Colors.grey.shade300),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search, color: Colors.grey),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SearchPage(products: products),
                              ),
                            );
                          },
                          splashRadius: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 0, bottom: 24),
                      itemCount: products.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return _buildProductCard(index: index, product: product);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: FloatingActionButton(
                onPressed: _navigateToAddProduct,
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}