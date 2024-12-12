class ProductModel {
  final int prodId;
  final String name;
  final int price;
  final String description;
  final String quantity;
  final int userId;
  final int prodTypeId;
  final String createdAt;
  final String updatedAt;
  final ProdType prodType;

  ProductModel({
    required this.prodId,
    required this.name,
    required this.price,
    required this.description,
    required this.quantity,
    required this.userId,
    required this.prodTypeId,
    required this.createdAt,
    required this.updatedAt,
    required this.prodType,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      prodId: json['prodId'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      quantity: json['quantity'] as String,
      userId: json['userId'] as int,
      prodTypeId: json['prodTypeId'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      prodType: ProdType.fromJson(json['prodType']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prodId': prodId,
      'name': name,
      'price': price,
      'description': description,
      'quantity': quantity,
      'userId': userId,
      'prodTypeId': prodTypeId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'prodType': prodType.toJson(),
    };
  }
}

class ProdType {
  final int prodTypeId;
  final String name;
  final String description;
  final String image;
  final String typeCode;
  final String createdAt;
  final String updatedAt;
  final List<Review> reviews;

  ProdType({
    required this.prodTypeId,
    required this.name,
    required this.description,
    required this.image,
    required this.typeCode,
    required this.createdAt,
    required this.updatedAt,
    required this.reviews,
  });

  factory ProdType.fromJson(Map<String, dynamic> json) {
    return ProdType(
      prodTypeId: json['prodTypeId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      typeCode: json['typeCode'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prodTypeId': prodTypeId,
      'name': name,
      'description': description,
      'image': image,
      'typeCode': typeCode,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}

class Review {
  final int id;
  final int rating;
  final String comment;
  final int prodId;
  final int userId;
  final String name;
  final int prodTypeId;
  final String createdAt;
  final String updatedAt;

  Review({
    required this.name,
    required this.id,
    required this.rating,
    required this.comment,
    required this.prodId,
    required this.userId,
    required this.prodTypeId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as int,
      name: json['name'] as String,
      rating: json['rating'] as int,
      comment: json['comment'] as String,
      prodId: json['prodId'] as int,
      userId: json['userId'] as int,
      prodTypeId: json['prodTypeId'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'comment': comment,
      'prodId': prodId,
      'userId': userId,
      'prodTypeId': prodTypeId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
