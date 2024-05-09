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
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.7,
      margin: const EdgeInsets.symmetric(vertical: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: coffee.rating.bgColor ?? colors.surface,
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
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              coffee.imageUrl,
              key: Key('coffee_card:image_${coffee.id}'),
              fit: BoxFit.cover,
              width: double.infinity,
              loadingBuilder: (_, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox.shrink();
              },
              errorBuilder: (_, __, ___) => Image.asset(
                'assets/images/coffee_placeholder.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(
              coffee.rating.icon,
              color: coffee.rating.iconColor ?? colors.onSurface,
            ),
          ),
        ],
      ),
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

  Color? get bgColor {
    switch (this) {
      case CoffeeRating.like:
        return Colors.green.shade100;
      case CoffeeRating.dislike:
        return Colors.red.shade100;
      case CoffeeRating.none:
        return null;
    }
  }

  Color? get iconColor {
    switch (this) {
      case CoffeeRating.like:
        return Colors.green;
      case CoffeeRating.dislike:
        return Colors.red;
      case CoffeeRating.none:
        return null;
    }
  }
}
