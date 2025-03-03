import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:retry/retry.dart';

const baseUrl = "https://api.gas.devku.xyz/api/v1";

class DioServiceAPI {
  final Dio _dio = Dio();

  // Fungsi untuk melakukan POST request dengan retry
  Future<Response?> postRequest({
    required String url,
    required String token,
    required Map<String, dynamic> data,
    int maxRetries = 3,
    int timeoutSeconds = 3,
  }) async {
    try {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      return await retry(
        () async {
          // Set headers dengan Bearer Token
          _dio.options.headers['Authorization'] = 'Bearer $token';

          // Kirim POST request dengan timeout
          final response = await _dio
              .post("$baseUrl/$url", data: data)
              .timeout(Duration(seconds: timeoutSeconds));

          return response;
        },
        retryIf: (e) => e is DioException || e is TimeoutException,
        maxAttempts: maxRetries,
      );
    } on DioException catch (e) {
      return _handleDioException(e, url);
    } catch (e) {
      return _handleUnknownError(e, url);
    }
  }

  Future<Response?> uploadFile({
    required String url,
    required String token,
    required String filePath,
    required Map<String, dynamic> data,
    String fieldName = "file",
    int maxRetries = 3,
    int timeoutSeconds = 10,
  }) async {
    try {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      return await retry(
        () async {
          _dio.options.headers['Authorization'] = 'Bearer $token';
          _dio.options.headers['Content-Type'] = 'multipart/form-data';

          FormData formData = FormData.fromMap({
            fieldName: await MultipartFile.fromFile(filePath,
                filename: filePath.split("/").last),
            ...data,
          });

          final response = await _dio
              .post("$baseUrl/$url", data: formData)
              .timeout(Duration(seconds: timeoutSeconds));

          return response;
        },
        retryIf: (e) => e is DioException || e is TimeoutException,
        maxAttempts: maxRetries,
      );
    } on DioException catch (e) {
      return _handleDioException(e, url);
    } catch (e) {
      return _handleUnknownError(e, url);
    }
  }

  Future<Response?> uploadFilePut({
    required String url,
    required String token,
    required String filePath,
    required Map<String, dynamic> data,
    String fieldName = "file",
    int maxRetries = 3,
    int timeoutSeconds = 10,
  }) async {
    try {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      return await retry(
        () async {
          _dio.options.headers['Authorization'] = 'Bearer $token';
          _dio.options.headers['Content-Type'] = 'multipart/form-data';

          FormData formData = FormData.fromMap({
            fieldName: await MultipartFile.fromFile(filePath,
                filename: filePath.split("/").last),
            ...data,
          });

          final response = await _dio
              .put("$baseUrl/$url", data: formData)
              .timeout(Duration(seconds: timeoutSeconds));

          return response;
        },
        retryIf: (e) => e is DioException || e is TimeoutException,
        maxAttempts: maxRetries,
      );
    } on DioException catch (e) {
      return _handleDioException(e, url);
    } catch (e) {
      return _handleUnknownError(e, url);
    }
  }

  // Fungsi untuk melakukan GET request dengan retry
  Future<Response?> getRequest({
    required String url,
    required String token,
    int maxRetries = 3,
    int timeoutSeconds = 1,
  }) async {
    try {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      return await retry(
        () async {
          _dio.options.headers['Authorization'] = 'Bearer $token';
          final response = await _dio
              .get("$baseUrl/$url")
              .timeout(Duration(seconds: timeoutSeconds));

          return response;
        },
        retryIf: (e) => e is DioException || e is TimeoutException,
        maxAttempts: maxRetries,
      );
    } on DioException catch (e) {
      return _handleDioException(e, url);
    } catch (e) {
      return _handleUnknownError(e, url);
    }
  }

  // Fungsi untuk melakukan PUT request dengan retry
  Future<Response?> putRequest({
    required String url,
    required String token,
    required Map<String, dynamic> data,
    int maxRetries = 3,
    int timeoutSeconds = 3,
  }) async {
    try {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      return await retry(
        () async {
          _dio.options.headers['Authorization'] = 'Bearer $token';
          final response = await _dio
              .put("$baseUrl/$url", data: data)
              .timeout(Duration(seconds: timeoutSeconds));

          return response;
        },
        retryIf: (e) => e is DioException || e is TimeoutException,
        maxAttempts: maxRetries,
      );
    } on DioException catch (e) {
      return _handleDioException(e, url);
    } catch (e) {
      return _handleUnknownError(e, url);
    }
  }

  // Fungsi untuk melakukan DELETE request dengan retry
  Future<Response?> deleteRequest({
    required String url,
    required String token,
    int maxRetries = 3,
    int timeoutSeconds = 3,
  }) async {
    try {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      return await retry(
        () async {
          _dio.options.headers['Authorization'] = 'Bearer $token';
          final response = await _dio
              .delete("$baseUrl/$url")
              .timeout(Duration(seconds: timeoutSeconds));

          return response;
        },
        retryIf: (e) => e is DioException || e is TimeoutException,
        maxAttempts: maxRetries,
      );
    } on DioException catch (e) {
      return _handleDioException(e, url);
    } catch (e) {
      return _handleUnknownError(e, url);
    }
  }

  // Fungsi untuk menangani DioException
  Response _handleDioException(DioException e, String url) {
    if (e.type == DioExceptionType.connectionError) {
      print('No connection, please check your internet');
      return Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 500,
          data: {'error': 'No connection'});
    } else if (e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      print('Request timeout');
      return Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 500,
          data: {'error': 'Request timeout'});
    } else {
      print('Error: ${e.response?.data}');
      return Response(
          requestOptions: RequestOptions(path: url),
          statusCode: e.response?.statusCode ?? 500,
          data: e.response?.data ?? {'error': 'Unknown error occurred'});
    }
  }

  // Fungsi untuk menangani error tidak dikenal
  Response _handleUnknownError(dynamic e, String url) {
    print('Unknown error: $e');
    return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 500,
        data: {'error': 'Unknown error occurred'});
  }
}
