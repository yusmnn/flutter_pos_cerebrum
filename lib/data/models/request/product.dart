class Product {
  final int? id;
  final String imagePath;
  final String title;
  final String description;
  final double price;
  int quantity;
  int purchased;

  Product({
    this.id,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    this.quantity = 1,
    this.purchased = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'title': title,
      'description': description,
      'price': price,
      'quantity': quantity,
      'purchased': purchased,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      imagePath: map['imagePath'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      quantity: map['quantity'] ?? 1,
      purchased: map['purchased'] ?? 0,
    );
  }
}
