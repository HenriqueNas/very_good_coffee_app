import 'dart:async';

import 'package:very_good_coffee_app/app/app.dart';

abstract class DependenciesInjector {
  static void initDependencies() {
    Dependencies.instance
      ..registerFactory<HttpClient>(() => httpClient)
      ..registerSingleton<LocalStorage>(localStorage);
  }

  static const httpClient = MockHttpClient();
  static final localStorage = InMemoryLocalStorage();
}

class MockHttpClient implements HttpClient {
  const MockHttpClient({
    this.fileUrl = 'https://coffee.alexflipnote.dev/Hy24s2Tyxi0_coffee.jpg',
  });

  final String fileUrl;

  @override
  String get baseUrl => 'test';

  @override
  HttpResponse<B> get<B>(
    String path, {
    Map<String, String>? headers,
  }) {
    if (path == '/random.json') {
      return HttpResponse(
        statusCode: 200,
        body: {'file': fileUrl} as B,
      );
    }

    throw UnimplementedError();
  }

  @override
  FutureOr<HttpResponse<B>> post<B>(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) =>
      throw UnimplementedError();
}

class InMemoryLocalStorage implements LocalStorage {
  InMemoryLocalStorage();

  final Map<String, dynamic> _storage = {};

  @override
  FutureOr<R?> read<R>(String key) => _storage[key] as R?;

  @override
  FutureOr<void> write(String key, Object value) => _storage[key] = value;
}
