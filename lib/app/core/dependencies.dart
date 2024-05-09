// coverage:ignore-file

import 'package:get_it/get_it.dart';
import 'package:very_good_coffee_app/app/data/externals/http_client.dart';
import 'package:very_good_coffee_app/app/data/externals/local_storage.dart';

abstract class Dependencies {
  static final instance = GetIt.instance;

  static void initDependencies() {
    instance
      ..registerFactory<HttpClient>(DioHttpClient.baseUrlFromEnvironment)
      ..registerFactory<LocalStorage>(SharedPreferencesLocalStorage.new);
  }
}
