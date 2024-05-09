// coverage:ignore-file

import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// An abstract class for making HTTP requests.
abstract interface class HttpClient {
  String get baseUrl;

  /// Makes a GET request to the given [path].
  FutureOr<HttpResponse<B>> get<B>(
    String path, {
    Map<String, String>? headers,
  });

  /// Makes a POST request to the given [path].
  FutureOr<HttpResponse<B>> post<B>(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
}

const _kDefaultEnvBaseUrl = String.fromEnvironment('API_BASE_URL');

/// An implementation of [HttpClient] that uses the `dio` package.
class DioHttpClient implements HttpClient {
  const DioHttpClient({
    required this.baseUrl,
    this.baseHeaders = const {},
  });

  DioHttpClient.baseUrlFromEnvironment({
    Map<String, dynamic> baseHeaders = const {},
  }) : this(
          baseUrl: _kDefaultEnvBaseUrl,
          baseHeaders: baseHeaders,
        );

  @override
  final String baseUrl;

  final Map<String, dynamic> baseHeaders;

  Dio get _client => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: baseHeaders,
        ),
      );

  @override
  Future<HttpResponse<B>> get<B>(
    String path, {
    Map<String, String>? headers,
  }) async {
    try {
      final result = await _client.get<dynamic>(
        '$baseUrl/$path',
        options: Options(headers: headers),
      );

      if (result.statusCode != null && result.data is B) {
        return HttpResponse(
          statusCode: result.statusCode!,
          body: result.data as B,
        );
      }

      throw Exception(
        'Invalid response: '
        'statusCode=${result.statusCode} '
        'data=${result.data}',
      );
    } on DioException catch (error) {
      if (kDebugMode) {
        log(
          '[DioHttpClient] Error: ${error.message}',
          error: error.error,
          stackTrace: error.stackTrace,
        );
      }

      return HttpResponse(
        statusCode: error.response?.statusCode ?? 500,
        message: error.message,
      );
    } catch (error) {
      if (kDebugMode) {
        log(
          '[DioHttpClient] Error: $error',
          error: error,
        );
      }
      return HttpResponse(
        statusCode: 500,
        message: error.toString(),
      );
    }
  }

  @override
  HttpResponse<B> post<B>(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    throw UnimplementedError();
  }
}

class HttpResponse<B> {
  const HttpResponse({
    required this.statusCode,
    this.message,
    this.body,
  });

  final int statusCode;
  final String? message;
  final B? body;
}
