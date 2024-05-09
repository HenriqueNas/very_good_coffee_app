import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/app/data/models/coffee_model.dart';

class CoffeeListTile extends StatelessWidget {
  const CoffeeListTile({
    required this.coffee,
    required this.onRemoveCoffee,
    super.key,
  });

  final CoffeeModel coffee;
  final void Function(CoffeeModel coffee) onRemoveCoffee;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 100,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      // row with image and remove button

      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Expanded(
              child: Image.network(
                coffee.imageUrl,
                key: Key('coffee_list_tile:image_${coffee.id}'),
                fit: BoxFit.cover,
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
            GestureDetector(
              onTap: () => onRemoveCoffee(coffee),
              child: Container(
                height: double.infinity,
                color: Theme.of(context).colorScheme.inversePrimary,
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.thumb_down_rounded,
                  size: 20,
                  color: isDarkMode //
                      ? Colors.red.shade600
                      : Colors.red.shade200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
