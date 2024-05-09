import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:very_good_coffee_app/app/app.dart';

typedef FileResponse = Map<String, dynamic>?;

const kDefaultCoffeeListSize = 5;

class CoffeeRepository {
  final HttpClient client = Dependencies.instance.get<HttpClient>();

  Future<List<String>> getListOfCoffeeImages([
    int listSize = kDefaultCoffeeListSize,
  ]) async {
    try {
      assert(
        listSize > 0,
        'The list size must be greater than 0, but was $listSize',
      );

      final listOfImagesRequests = List.generate(
        listSize,
        (_) async => client.get<FileResponse>('/random.json'),
      );

      final requestResult = await Future.wait(listOfImagesRequests);

      final imageList = <String>[];
      for (final request in requestResult) {
        final imageUrl = (request.body as Map?)?['file'];
        if (imageUrl != null && imageUrl is String) {
          imageList.add(imageUrl);
        }
      }

      return imageList;
    } catch (error) {
      if (kDebugMode) {
        logError(
          'getListOfCoffeeImages',
          error,
        );
      }
      rethrow;
    }
  }

  Future<String> getCoffeeImage() async {
    try {
      final response = await client.get<FileResponse>('/random.json');
      return response.body?['file'] as String? ?? '';
    } catch (error) {
      if (kDebugMode) {
        logError('getCoffeeImage', error);
      }
      rethrow;
    }
  }

  void logError(String methodName, Object error) {
    if (kDebugMode) {
      log(
        'An error occurred in $methodName',
        name: 'CoffeeRepository',
        error: error,
      );
    }
  }
}
