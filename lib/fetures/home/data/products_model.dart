class ProductsModel {
  final String name;
  final double rate;
  final List<String> imageUrl;
  final String dec;
  final String colors;
  final String category;
  final String material;
  final int price;
  final bool? isbestSallers;
  // ignore: non_constant_identifier_names
  final int products_ID;

  ProductsModel({
    // ignore: non_constant_identifier_names
    required this.products_ID,
    required this.name,
    required this.rate,
    required this.imageUrl,
    required this.isbestSallers,
    required this.dec,
    required this.colors,
    required this.category,
    required this.material,
    required this.price,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      name: (json['name'] ?? '').toString(),

      rate: (json['rate'] ?? 0).toDouble(),

      imageUrl: json['imageURL'] == null
          ? []
          : List<String>.from(json['imageURL']),

      dec: (json['des'] ?? '').toString(),

      colors: (json['colors'] ?? '').toString(),

      category: (json['category'] ?? '').toString(),

      material: (json['material'] ?? '').toString(),

      price: json['price'] is int
          ? json['price']
          : int.tryParse(json['price'].toString()) ?? 0,
      isbestSallers: json['isbestSallers'],
      products_ID: json["products_ID"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rate': rate,
      'colors': colors,
      'imageURL': imageUrl,
      'des': dec,
      'category': category,
      'material': material,
      'price': price,
      "products_ID": products_ID,
    };
  }
}

class Catogerymodel {
  final String name;
  final String imageUrl;

  Catogerymodel({required this.name, required this.imageUrl});

  factory Catogerymodel.fromJson(Map<String, dynamic> json) {
    return Catogerymodel(
      name: (json['name'] ?? '').toString(),

      imageUrl: json['imageURL'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'imageURL': imageUrl};
  }
}
