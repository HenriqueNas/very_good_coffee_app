import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/app/data/models/coffee_model.dart';

class CoffeeCard extends StatelessWidget {
  const CoffeeCard({
    required this.coffee,
    super.key,
  });

  final CoffeeModel coffee;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          height: 350,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: coffee.rating.bgColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            coffee.rating.icon,
            color: coffee.rating.iconColor,
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Image.network(
            coffee.imageUrl,
            key: Key('coffee_card:image_${coffee.id}'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
            loadingBuilder: (_, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (_, __, ___) {
              return const Center(child: Icon(Icons.error));
            },
          ),
        ),
      ],
    );
  }
}

extension on CoffeeRating {
  IconData get icon {
    switch (this) {
      case CoffeeRating.like:
        return Icons.thumb_up_rounded;
      case CoffeeRating.dislike:
        return Icons.thumb_down_rounded;
      case CoffeeRating.none:
        return Icons.thumbs_up_down_outlined;
    }
  }

  Color get bgColor {
    switch (this) {
      case CoffeeRating.like:
        return Colors.green.shade100;
      case CoffeeRating.dislike:
        return Colors.red.shade100;
      case CoffeeRating.none:
        return Colors.grey.shade200;
    }
  }

  Color get iconColor {
    switch (this) {
      case CoffeeRating.like:
        return Colors.green;
      case CoffeeRating.dislike:
        return Colors.red;
      case CoffeeRating.none:
        return Colors.black;
    }
  }
}
