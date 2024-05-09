import 'package:flutter/material.dart';

class RatingButtons extends StatelessWidget {
  const RatingButtons({
    required this.onLike,
    required this.onDislike,
    required this.onUndo,
    super.key,
  });

  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback onUndo;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: onDislike,
          backgroundColor: isDarkMode //
              ? Colors.red.shade600
              : Colors.red.shade300,
          child: const Icon(Icons.thumb_down_outlined),
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          onPressed: onUndo,
          backgroundColor: isDarkMode //
              ? Colors.grey.shade600
              : Colors.grey.shade300,
          child: const Icon(Icons.undo),
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          onPressed: onLike,
          backgroundColor: isDarkMode //
              ? Colors.green.shade600
              : Colors.green.shade300,
          child: const Icon(Icons.thumb_up_outlined),
        ),
      ],
    );
  }
}
