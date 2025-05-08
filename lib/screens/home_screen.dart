import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/item_tile.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';
import 'category_screen.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Item> featuredItems = [
    Item(name: 'Apple MacBook Pro M4', price: 2199.00, imageUrl: 'assets/images/laptop.png'),
    Item(name: 'Iphone 14', price: 750.00, imageUrl: 'assets/images/phone.png'),
    Item(name: 'AIAIAI 3.5mm Jack 2m wire - Headphones', price: 25.00, imageUrl: 'assets/images/headphones.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text('Chauhan Shop', style: theme.textTheme.headlineMedium),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CartScreen()),
                ),
              ),
              const SizedBox(width: 8),
            ],
            floating: true,
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: theme.colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.local_shipping_outlined,
                            size: 36,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Free Shipping',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: theme.colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'On all orders over \$50',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Categories',
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryItem(context, 'Electronics', Icons.devices, theme.colorScheme.primary),
                    _buildCategoryItem(context, 'Clothing', Icons.checkroom, theme.colorScheme.secondary),
                    _buildCategoryItem(context, 'Services', Icons.miscellaneous_services, theme.colorScheme.tertiary),
                    _buildCategoryItem(context, 'Grocery', Icons.shopping_basket, theme.colorScheme.error),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Featured Products',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProductDetailScreen(item: featuredItems[i])),
                    ),
                    child: ItemTile(item: featuredItems[i], showButton: false),
                  ),
                ),
                childCount: featuredItems.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (_) => CategoryScreen())
        ),
        icon: const Icon(Icons.category_outlined),
        label: const Text('All Categories'),
      ),
    );
  }
  
  Widget _buildCategoryItem(BuildContext context, String name, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductListScreen(category: name),
          ),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 8),
            Text(name),
          ],
        ),
      ),
    );
  }
}
