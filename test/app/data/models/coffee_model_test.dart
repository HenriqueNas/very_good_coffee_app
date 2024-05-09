import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/app/data/models/coffee_model.dart';

void main() {
  group('CoffeeModel', () {
    test('constructor creates CoffeeModel instance with default rating', () {
      const coffee = CoffeeModel(
        id: '1',
        imageUrl: 'https://example.com/image.jpg',
        rating: CoffeeRating.none,
      );

      expect(coffee.id, '1');
      expect(coffee.imageUrl, 'https://example.com/image.jpg');
      expect(coffee.rating, CoffeeRating.none);
    });

    test(
        'fromImageUrl creates CoffeeModel instance with extracted ID and default rating',
        () {
      final coffee =
          CoffeeModel.fromImageUrl('https://example.com/coffee/1.jpg');

      expect(coffee.id, '1.jpg');
      expect(coffee.imageUrl, 'https://example.com/coffee/1.jpg');
      expect(coffee.rating, CoffeeRating.none);
    });

    test('fromMap creates CoffeeModel instance from map representation', () {
      final coffeeMap = {
        'id': '2',
        'imageUrl': 'https://example.com/coffee/2.jpg',
        'rating': 'like',
      };

      final coffee = CoffeeModel.fromMap(coffeeMap);

      expect(coffee.id, '2');
      expect(coffee.imageUrl, 'https://example.com/coffee/2.jpg');
      expect(coffee.rating, CoffeeRating.like);
    });

    test('getIdFromCoffeeUrl extracts ID from coffee image URL', () {
      final id =
          CoffeeModel.getIdFromCoffeeUrl('https://example.com/coffee/3.jpg');

      expect(id, '3.jpg');
    });

    test('toMap converts CoffeeModel instance to map representation', () {
      const coffee = CoffeeModel(
        id: '4',
        imageUrl: 'https://example.com/coffee/4.jpg',
        rating: CoffeeRating.dislike,
      );

      final coffeeMap = coffee.toMap();

      expect(coffeeMap['id'], '4');
      expect(coffeeMap['imageUrl'], 'https://example.com/coffee/4.jpg');
      expect(coffeeMap['rating'], 'dislike');
    });

    test('equality and hash code work correctly', () {
      const coffee1 = CoffeeModel(
        id: '5',
        imageUrl: 'https://example.com/coffee/5.jpg',
        rating: CoffeeRating.like,
      );

      const coffee2 = CoffeeModel(
        id: '5',
        imageUrl: 'https://example.com/coffee/5.jpg',
        rating: CoffeeRating.like,
      );

      expect(coffee1 == coffee2, true);
      expect(coffee1.hashCode == coffee2.hashCode, true);
    });

    test('toString returns the expected string representation', () {
      const coffee = CoffeeModel(
        id: '6',
        imageUrl: 'https://example.com/coffee/6.jpg',
        rating: CoffeeRating.none,
      );

      expect(
        coffee.toString(),
        'CoffeeModel(id: 6, rating: CoffeeRating.none)',
      );
    });
  });

  group('CoffeeRating', () {
    test('isLike returns true for CoffeeRating.like', () {
      expect(CoffeeRating.like.isLike, true);
      expect(CoffeeRating.dislike.isLike, false);
      expect(CoffeeRating.none.isLike, false);
    });

    test('fromName returns correct CoffeeRating from string', () {
      expect(CoffeeRating.fromName('like'), CoffeeRating.like);
      expect(CoffeeRating.fromName('dislike'), CoffeeRating.dislike);
      expect(CoffeeRating.fromName('none'), CoffeeRating.none);
      expect(CoffeeRating.fromName('unknown'), CoffeeRating.none);
    });
  });
}
