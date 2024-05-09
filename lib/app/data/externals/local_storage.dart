import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An abstract class for reading and writing to local data.
abstract interface class LocalStorage {
  /// Reads the value associated with the given [key].
  FutureOr<R?> read<R>(String key);

  /// Writes the given [value] to the given [key].
  FutureOr<void> write(String key, Object value);
}

/// An implementation of [LocalStorage] that uses shared preferences.
class SharedPreferencesLocalStorage implements LocalStorage {
  const SharedPreferencesLocalStorage();

  static const String _baseKey = 'coffee_app';

  @override
  Future<R?> read<R>(String key) async {
    try {
      final localData = await SharedPreferences.getInstance();
      final result = localData.getString('$_baseKey@$key');
      final decodedResult = result != null ? jsonDecode(result) : null;

      return decodedResult as R?;
    } catch (error) {
      if (kDebugMode) {
        log(
          'Error reading from local storage',
          name: 'SharedPreferencesLocalStorage',
          error: error,
        );
      }

      return null;
    }
  }

  @override
  Future<void> write(String key, Object value) async {
    try {
      final localData = await SharedPreferences.getInstance();
      await localData.setString('$_baseKey@$key', jsonEncode(value));
    } catch (error) {
      if (kDebugMode) {
        log(
          'Error writing to local storage',
          name: 'SharedPreferencesLocalStorage',
          error: error,
        );
      }
    }
  }
}
