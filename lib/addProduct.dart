import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
import 'product.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  XFile? _imageFile;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // Sizes logic
  final List<int> _allSizes = [37, 38, 39, 40, 41, 42, 43, 44];
  final Set<int> _selectedSizes = {};

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = picked;
      });
    }
  }

  Future<void> _addProduct() async {
    final name = _nameController.text.trim();
    final category = _categoryController.text.trim();
    final price = _priceController.text.trim();
    final desc = _descController.text.trim();

    if (name.isEmpty || category.isEmpty || price.isEmpty || desc.isEmpty || _imageFile == null || _selectedSizes.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Missing Fields'),
          content: const Text('Please fill all fields, select sizes, and upload an image.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
          ],
        ),
      );
      return;
    }
    dynamic imageData;
    if (kIsWeb) {
      imageData = await _imageFile!.readAsBytes();
    } else {
      imageData = _imageFile;
    }

    final product = Product(
      name: name,
      category: category,
      price: price,
      desc: desc,
      image: imageData,
      sizes: _selectedSizes.toList(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product added successfully')),
    );

    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.pop(context, product);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (_imageFile == null) {
      imageWidget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.image_outlined, size: 48, color: Colors.grey),
          SizedBox(height: 8),
          Text('upload image', style: TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      );
    } else if (kIsWeb) {
      imageWidget = FutureBuilder<Uint8List>(
        future: _imageFile!.readAsBytes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.memory(
                snapshot.data!,
                width: 366,
                height: 190,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      );
    } else {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          File(_imageFile!.path),
          width: 366,
          height: 190,
          fit: BoxFit.cover,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: SizedBox(
          width: 104,
          height: 24,
          child: Center(
            child: Text(
              'Add Product',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                height: 1.0,
                letterSpacing: 0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 380,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Upload image area
                Container(
                  width: 366,
                  height: 190,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6FA),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: imageWidget,
                  ),
                ),
                const SizedBox(height: 24),
                // Name field
                const Text('name', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                const SizedBox(height: 6),
                Center(
                  child: SizedBox(
                    width: 366,
                    height: 50,
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF0F1F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFB0B4BC)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Category field
                const Text('category', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                const SizedBox(height: 6),
                Center(
                  child: SizedBox(
                    width: 366,
                    height: 50,
                    child: TextField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF0F1F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFB0B4BC)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Price field
                const Text('price', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                const SizedBox(height: 6),
                Center(
                  child: SizedBox(
                    width: 366,
                    height: 50,
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF0F1F5),
                        suffixText: '\$',
                        suffixStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFB0B4BC)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Description field
                const Text('description', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                const SizedBox(height: 6),
                Center(
                  child: SizedBox(
                    width: 366,
                    height: 79,
                    child: TextField(
                      controller: _descController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF0F1F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xFFB0B4BC)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Sizes selection
                const Text('Available Sizes', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
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
                const SizedBox(height: 32),
                // ADD button
                Center(
                  child: SizedBox(
                    width: 366,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _addProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3D5CFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text('ADD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // DELETE button
                Center(
                  child: SizedBox(
                    width: 366,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text('DELETE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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