import 'package:flutter/material.dart';
import 'description.dart';

// ...existing imports...

class SearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  const SearchPage({Key? key, required this.products}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double _price = 120;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  List<Map<String, dynamic>> filteredProducts = [];
  bool showFilters = false;

  @override
  void initState() {
    super.initState();
    filteredProducts = List.from(widget.products);
    _searchController.addListener(_runSearch); // Live filtering as you type
  }

  @override
  void dispose() {
    _searchController.removeListener(_runSearch);
    _searchController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _runSearch() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredProducts = widget.products.where((product) {
        return product['name'].toString().toLowerCase().contains(query) ||
               product['category'].toString().toLowerCase().contains(query) ||
               (product['desc'] ?? '').toString().toLowerCase().contains(query);
      }).toList();
    });
  }

  void _runFilter() {
    String category = _categoryController.text.toLowerCase();
    setState(() {
      filteredProducts = widget.products.where((product) {
        final matchesCategory = category.isEmpty
            ? true
            : product['category'].toString().toLowerCase().contains(category);
        final priceValue = double.tryParse(
            product['price'].toString().replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
        final matchesPrice = priceValue <= _price;
        return matchesCategory && matchesPrice;
      }).toList();
      showFilters = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int resultCount = filteredProducts.length;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ...existing search bar and filter row...
                Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Ink(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Color(0xFF3D5CFF)),
                          onPressed: () => Navigator.pop(context),
                          splashRadius: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Search  Product',
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 36),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search',
                                ),
                                style: const TextStyle(fontSize: 15),
                                // onChanged handled by addListener in initState
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward, color: Color(0xFF3D5CFF)),
                              onPressed: _runSearch,
                              splashRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.filter_alt_outlined, color: Color(0xFF3D5CFF)),
                        onPressed: () {
                          setState(() {
                            showFilters = !showFilters;
                          });
                        },
                        splashRadius: 20,
                      ),
                    ),
                  ],
                ),
                if (showFilters) ...[
                  const SizedBox(height: 20),
                  // Category field
                  Text('Category', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  const SizedBox(height: 6),
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _categoryController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        hintText: '',
                      ),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Price slider
                  Text('Price', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  const SizedBox(height: 6),
                  // Show the selected price value
                  Text(
                    'Up to \$${_price.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w400),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                    ),
                    child: Slider(
                      value: _price,
                      min: 0,
                      max: 120,
                      divisions: 12,
                      activeColor: const Color(0xFF3D5CFF),
                      inactiveColor: Colors.grey.shade300,
                      onChanged: (value) {
                        setState(() {
                          _price = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _runFilter,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3D5CFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('APPLY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                const SizedBox(height: 20),
                // Results count
                Text(
                  resultCount == 0
                      ? '0 results found'
                      : '$resultCount result${resultCount > 1 ? 's' : ''} found',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                // Product List
                if (resultCount == 0)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Icon(Icons.search_off, size: 48, color: Colors.grey),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProducts.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DescriptionPage(
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
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: product['isAsset'] == true
                                    ? Image.asset(
                                        product['image'],
                                        height: 120,
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          height: 120,
                                          color: Colors.grey[200],
                                          child: const Icon(Icons.image, size: 40, color: Colors.grey),
                                        ),
                                      )
                                    : Container(
                                        height: 120,
                                        color: Colors.grey[200],
                                        child: const Icon(Icons.image, size: 40, color: Colors.grey),
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            product['name'],
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                          ),
                                        ),
                                        Text(
                                          product['price'],
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                        ),
                                      ],
                                    ), 
                                    Row(
                                      children: [
                                        Text(
                                          product['category'],
                                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                                        ),
                                        const Spacer(),
                                        const Icon(Icons.star, color: Colors.amber, size: 16),
                                        const SizedBox(width: 2),
                                        Text('(${(product['rating'] as double).toStringAsFixed(1)})', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                                      ],
                                    ),
                                    if ((product['desc'] ?? '').isNotEmpty) ...[
                                      const SizedBox(height: 6),
                                      Text(
                                        product['desc'],
                                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}