import 'package:flutter/material.dart';

class LoadingCoffee extends StatelessWidget {
  const LoadingCoffee({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
