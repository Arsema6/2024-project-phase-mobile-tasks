class Product {
  final String name;
  final String category;
  final String price;
  final String desc;
  final dynamic image; // XFile for mobile, Uint8List for web
  final List<int> sizes; // List of available sizes

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.desc,
    required this.image,
    required this.sizes,
  });
}