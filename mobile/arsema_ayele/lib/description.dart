import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List, XFile;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'edit_product.dart';

class DescriptionPage extends StatelessWidget {
  final dynamic image;
  final String name;
  final String price;
  final double rating;
  final String category;
  final String desc;
  final List<int> sizes; // <-- Accept sizes

  const DescriptionPage({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
    required this.category,
    required this.desc,
    required this.sizes, // <-- Accept sizes
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (image is String) {
imageWidget = Image.asset(
  image,
  width: 430,
  height: 286,
  fit: BoxFit.cover,
  alignment: Alignment.bottomCenter, // <-- Fills width, shows bottom
  errorBuilder: (context, error, stackTrace) => Container(
    width: 430,
    height: 286,
    color: Colors.grey[200],
    child: const Icon(Icons.image, size: 40, color: Colors.grey),
  ),
);
} else if (kIsWeb && image is Uint8List) {
  imageWidget = Image.memory(
    image,
    width: 430,
    height: 286,
    fit: BoxFit.cover,
    alignment: Alignment.bottomCenter, // <-- Show bottom of image
  );
} else if (image is XFile) {
  imageWidget = Image.file(
    File((image as XFile).path),
    width: 430,
    height: 286,
    fit: BoxFit.cover,
    alignment: Alignment.bottomCenter, // <-- Show bottom of image
  );
} else {
  imageWidget = Container(
    width: 430,
    height: 286,
    color: Colors.grey[200],
    child: const Icon(Icons.image, size: 40, color: Colors.grey),
  );
}

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top image with back button overlay and layout properties
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        child: imageWidget,
                      ),
                      Positioned(
                        top: 24,
                        left: 16,
                        child: Material(
                          color: Colors.white.withOpacity(0.8),
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () => Navigator.of(context).pop(),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_back, color: Colors.blue, size: 28),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Main content container (no inner padding)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        // Category and rating row
                        Row(
                          children: [
                            Text(category, style: const TextStyle(fontSize: 15, color: Colors.grey)),
                            const Spacer(),
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text('(${rating.toStringAsFixed(1)})', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Name and price row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ),
                            Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          ],
                        ),
                        const SizedBox(height: 18),
                        // Available Sizes
                        if (sizes.isNotEmpty) ...[
                          const Text('Available Sizes:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            children: sizes.map((size) => Chip(
                              label: Text(size.toString()),
                              backgroundColor: Colors.blue.shade50,
                            )).toList(),
                          ),
                          const SizedBox(height: 18),
                        ],
                        // Description
                        Text(
                          desc.isNotEmpty
                              ? desc
                              : '''Ride like a pro with BLING by Supacaz – precision-fit dual BOA® dials, NASA-grade carbon sole for max power, airflow vents to keep cool, and smart comfort tech inside. Tough, sleek, and cleat-ready. Pedal with style.''',
  style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
),
                        const SizedBox(height: 28),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'delete');
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    side: const BorderSide(color: Colors.red, width: 1.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 0),
                                  ),
                                  child: const Text('DELETE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final updatedProduct = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProductPage(
                                          image: image,
                                          name: name,
                                          price: price,
                                          rating: rating,
                                          category: category,
                                          sizes: sizes,
                                        ),
                                      ),
                                    );
                                    if (updatedProduct != null) {
                                      Navigator.pop(context, {'action': 'update', 'product': updatedProduct});
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3D5CFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 0),
                                  ),
                                  child: const Text('UPDATE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}