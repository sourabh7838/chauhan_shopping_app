import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPaymentMethod = 'Credit Card';
  
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'Credit Card',
      'icon': Icons.credit_card,
      'description': 'Pay with Visa, Mastercard, or American Express'
    },
    {
      'name': 'Debit Card',
      'icon': Icons.credit_card,
      'description': 'Pay with your bank debit card'
    },
    {
      'name': 'Apple Pay',
      'icon': Icons.apple,
      'description': 'Fast and secure payment with Apple Pay'
    },
  ];

  void _placeOrder(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Order Placed Successfully!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text('Thank you for your purchase! Your order has been confirmed and will be processed immediately.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              cart.clearCart();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cart = Provider.of<CartProvider>(context);
    final subtotal = cart.total;
    final tax = subtotal * 0.02;
    final shipping = subtotal > 50 ? 0.0 : 5.99;
    final total = subtotal + tax + shipping;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: theme.textTheme.titleLarge),
      ),
      body: cart.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: theme.colorScheme.primary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add some items before checkout',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: const Text('Continue Shopping'),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                Text(
                  'Order Summary',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: theme.textTheme.bodyLarge,
                            ),
                            Text(
                              '\$${subtotal.toStringAsFixed(2)}',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tax (2%)',
                              style: theme.textTheme.bodyLarge,
                            ),
                            Text(
                              '\$${tax.toStringAsFixed(2)}',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping',
                              style: theme.textTheme.bodyLarge,
                            ),
                            Text(
                              shipping > 0 ? '\$${shipping.toStringAsFixed(2)}' : 'FREE',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: shipping > 0 ? null : Colors.green,
                                fontWeight: shipping > 0 ? null : FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (shipping == 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              'Free shipping on orders over \$50',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.green,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${total.toStringAsFixed(2)}',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Shipping Address',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Default Address',
                              style: theme.textTheme.titleMedium,
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Change'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Sourabh Chauhan\n123 Main Street\nApartment 4B\nBangalore, Karnataka 560001\nIndia\n+91 9876543210',
                          style: TextStyle(height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Choose Payment Method',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                ..._paymentMethods.map((method) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: RadioListTile<String>(
                    title: Row(
                      children: [
                        Icon(method['icon'] as IconData, color: theme.colorScheme.primary),
                        const SizedBox(width: 12),
                        Text(method['name']),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(method['description']),
                    ),
                    value: method['name'],
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value!;
                      });
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                )),
                const SizedBox(height: 32),
                FilledButton.icon(
                  onPressed: () => _placeOrder(context),
                  icon: const Icon(Icons.payment),
                  label: Text('Pay \$${total.toStringAsFixed(2)}'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_outline, size: 16, color: theme.colorScheme.outline),
                      const SizedBox(width: 8),
                      Text(
                        'Secure payment processing',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
    );
  }
}
