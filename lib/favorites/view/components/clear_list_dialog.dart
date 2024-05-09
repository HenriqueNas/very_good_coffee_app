import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

class ClearListDialog extends StatelessWidget {
  const ClearListDialog({super.key});

  static void open(BuildContext context) => showDialog<String>(
        context: context,
        builder: (_) => const ClearListDialog(),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final cubit = context.read<LikedCoffeesCubit>();

    return Dialog(
      key: const Key('clear_list_dialog'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l10n.clearFavoritesDialogTitle),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l10n.clearFavoritesDialogMessage),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: Text(l10n.clearFavoritesDialogCancel),
              ),
              TextButton(
                onPressed: () {
                  cubit.clearCoffeeList();
                  Navigator.of(context).pop();
                },
                child: Text(l10n.clearFavoritesDialogOk),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
