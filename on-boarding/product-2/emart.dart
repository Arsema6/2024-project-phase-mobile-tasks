import 'dart:io';
class Product {
    String name;
    String description;
    double price;

    Product(this.name, this.description, this.price);
}
class ProductManagement{
    List<Product> products= [];
    void addProduct() {
        print('Enter product name: ');
        String name = stdin.readLineSync() ?? '';
        print('Enter product description: ');
        String description = stdin.readLineSync() ?? '';
        print('Enter product price: ');
        double price = double.parse(stdin.readLineSync()!);

    Product product = Product(name, description, price);
    products.add(product);
    print('Product added successfully.');
  }
  void viewAllProducts() {
    if (products.isEmpty) {
      print('No products found.');
      return;
      }

    // Column headers with padding
    print(
      '\n| No. | Name             | Description                  | Price     |');
    print(
      '|-----|------------------|------------------------------|-----------|');

    for (int i = 0; i < products.length; i++) {
      Product p = products[i];
      print(
        '| ${i + 1}.  '
        '| ${p.name.padRight(16)}'
        '| ${p.description.padRight(28)}'
        '| \$${p.price.toStringAsFixed(2).padRight(9)}|'
      );
    }
}
  void viewSingleProduct() {
    print('Enter product number to view: ');
    int index = int.parse(stdin.readLineSync()!) - 1;
    if (index < 0 || index >= products.length) {
      print('Product not found.');
      return;
    }

    Product p = products[index];
    print('\n Product Details');
    print('Name       : ${p.name}');
    print('Description: ${p.description}');
    print('Price      : \$${p.price}');
  }
  void updateProduct() {
    stdout.write('Enter product number to update: ');
    int index = int.parse(stdin.readLineSync()!) - 1;
    if (index < 0 || index >= products.length) {
      print('Product not found.');
      return;
    }

    print('New name: ');
    products[index].name = stdin.readLineSync() ?? products[index].name;
    print('New description: ');
    products[index].description = stdin.readLineSync() ?? products[index].description;
    print('New price: ');
    products[index].price = double.parse(stdin.readLineSync()!);

    print('Product updated successfully.');
  }
  void deleteProduct() {
    print('Enter product number to delete: ');
    int index = int.parse(stdin.readLineSync()!) - 1;
    if (index < 0 || index >= products.length) {
      print('Product not found.');
      return;
    }
    print('Deleted ${products[index].name} successfully.');
    products.removeAt(index);
  }
}
void main() {
  ProductManagement manager = ProductManagement();

  while (true) {
    print('\n==============================');
    print('      Welcome to E-Mart');
    print('==============================');
    print('[1] Add Product');
    print('[2] View All Products');
    print('[3] View Single Product');
    print('[4] Edit Product');
    print('[5] Delete Product');
    print('[6] Exit');

    stdout.write('Choose an option: ');
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
        case 1:
            manager.addProduct();
            break;
        case 2:
            manager.viewAllProducts();
            break;
        case 3:
            manager.viewSingleProduct();
            break;
        case 4:
            manager.updateProduct();
            break;
        case 5:
            manager.deleteProduct();
            break;
        case 6:
            print('Good bye!');
            return;
        default:
            print('Invalid option. Try again.');
        }
    }
}
