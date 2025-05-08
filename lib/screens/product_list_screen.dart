import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/item_tile.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  final String category;

  ProductListScreen({required this.category});

  final Map<String, List<Item>> productMap = {
    'Electronics': [
      Item(name: 'Apple MacBook Pro M4', price: 2199.00, imageUrl: 'assets/images/laptop.png'),
      Item(name: 'Iphone 14', price: 750.00, imageUrl: 'assets/images/phone.png'),
      Item(name: 'AIAIAI 3.5mm Jack 2m wire - Headphones', price: 25.00, imageUrl: 'assets/images/headphones.png'),
    ],
    'Clothing': [
      Item(name: 'T-Shirt – White Cotton', price: 29.99, imageUrl: 'assets/images/clothing1.png'),
      Item(name: 'Denim Jacket', price: 89.99, imageUrl: 'assets/images/clothing2.png'),
    ],
    'Services': [
      Item(name: 'Device Repair Service', price: 49.00, imageUrl: 'assets/images/services1.png'),
    ],
    'Grocery': [
      Item(name: 'Organic Apples (1kg)', price: 5.49, imageUrl: 'assets/images/grocery1.png'),
      Item(name: 'Whole Milk (1L)', price: 2.99, imageUrl: 'assets/images/grocery2.png'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final products = productMap[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(category, style: theme.textTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              '${products.length} products found',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(item: product),
                      ),
                    ),
                    child: ItemTile(item: product, showButton: false),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
