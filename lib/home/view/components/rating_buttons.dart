import 'package:flutter/material.dart';

class RatingButtons extends StatelessWidget {
  const RatingButtons({
    required this.onLike,
    required this.onDislike,
    super.key,
  });

  final VoidCallback onLike;
  final VoidCallback onDislike;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: onDislike,
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.thumb_down_outlined),
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          onPressed: onLike,
          backgroundColor: Colors.green,
          child: const Icon(Icons.thumb_up_outlined),
        ),
      ],
    );
  }
}
