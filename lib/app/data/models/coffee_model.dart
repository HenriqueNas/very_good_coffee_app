import 'package:flutter/foundation.dart';

@immutable
class CoffeeModel {
  const CoffeeModel({
    required this.id,
    required this.imageUrl,
    required this.rating,
  });

  factory CoffeeModel.fromImageUrl(String imageUrl) {
    return CoffeeModel(
      id: getIdFromCoffeeUrl(imageUrl),
      imageUrl: imageUrl,
      rating: CoffeeRating.none,
    );
  }

  factory CoffeeModel.fromMap(Map<String, dynamic> map) {
    assert(map['id'] is String, 'id must be a non null String');
    assert(map['imageUrl'] is String, 'imageUrl must be a non null String');
    assert(map['rating'] is String, 'rating must be a non null String');

    return CoffeeModel(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      rating: CoffeeRating.fromName(map['rating'] as String?),
    );
  }

  static String getIdFromCoffeeUrl(String url) {
    return url.split('/').last;
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'imageUrl': imageUrl,
        'rating': rating.name,
      };

  final String id;
  final String imageUrl;
  final CoffeeRating rating;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CoffeeModel && other.id == id && other.rating == rating;
  }

  @override
  int get hashCode => id.hashCode ^ rating.hashCode;

  @override
  String toString() => 'CoffeeModel(id: $id, rating: $rating)';
}

enum CoffeeRating {
  like,
  dislike,
  none;

  bool get isLike => this == CoffeeRating.like;

  static CoffeeRating fromName(String? name) {
    final rating = switch (name?.toLowerCase()) {
      'like' => CoffeeRating.like,
      'dislike' => CoffeeRating.dislike,
      _ => CoffeeRating.none,
    };

    return rating;
  }
}
