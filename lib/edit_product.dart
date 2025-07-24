import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final double rating;
  final String category;
  final List<int> sizes; // <-- Add this

  const EditProductPage({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
    required this.category,
    required this.sizes, // <-- Add this
  }) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController ratingController;
  late TextEditingController categoryController;

  final List<int> _allSizes = [37, 38, 39, 40, 41, 42, 43, 44];
  late Set<int> _selectedSizes;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    priceController = TextEditingController(text: widget.price);
    ratingController = TextEditingController(text: widget.rating.toString());
    categoryController = TextEditingController(text: widget.category);
    _selectedSizes = Set<int>.from(widget.sizes); // <-- Initialize with passed sizes
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    ratingController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: ratingController,
                decoration: const InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Available Sizes', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 10,
                children: _allSizes.map((size) {
                  return FilterChip(
                    label: Text(size.toString()),
                    selected: _selectedSizes.contains(size),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedSizes.add(size);
                        } else {
                          _selectedSizes.remove(size);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'name': nameController.text,
                    'price': priceController.text,
                    'rating': double.tryParse(ratingController.text) ?? widget.rating,
                    'category': categoryController.text,
                    'image': widget.image,
                    'sizes': _selectedSizes.toList(), // <-- Return selected sizes
                  });
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}