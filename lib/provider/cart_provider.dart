import 'package:flutter/foundation.dart';
import '../models/item.dart';

class CartProvider with ChangeNotifier {
  final Map<Item, int> _items = {};

  Map<Item, int> get items => _items;

  double get total => _items.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  void addItem(Item item) {
    _items.update(item, (qty) => qty + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  void incrementQuantity(Item item) {
    if (_items.containsKey(item)) {
      _items[item] = _items[item]! + 1;
      notifyListeners();
    }
  }

  void decrementQuantity(Item item) {
    if (_items.containsKey(item) && _items[item]! > 1) {
      _items[item] = _items[item]! - 1;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int getItemQuantity(Item item) {
    return _items[item] ?? 0;
  }

  bool isInCart(Item item) {
    return _items.containsKey(item);
  }
}


