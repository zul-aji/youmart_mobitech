class CartItem {
  final String pid, image, name;
  final double price;
  final int quantity;
  CartItem(
      {required this.quantity,
      required this.pid,
      required this.name,
      required this.price,
      required this.image});
}

List<CartItem> cartItem = <CartItem>[];
