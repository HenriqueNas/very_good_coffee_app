import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/app/data/models/coffee_model.dart';

class CoffeeListTile extends StatelessWidget {
  const CoffeeListTile({
    required this.coffee,
    required this.onRemoveCoffee,
    super.key,
  });

  final CoffeeModel coffee;
  final VoidCallback onRemoveCoffee;

  @override
  Widget build(BuildContext context) {
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
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Expanded(
            child: Image.network(
              coffee.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onTap: onRemoveCoffee,
            child: Container(
              height: double.infinity,
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Icons.thumb_down_rounded,
                size: 20,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
