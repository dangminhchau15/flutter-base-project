import 'dart:convert';
import 'dart:io';

import 'package:app/datasources/exceptions/custom_exception.dart';
import 'package:app/datasources/local/share_pref_provider.dart';
import 'package:app/datasources/networks/network_service_response.dart';
import 'package:dio/dio.dart';

class RestClient {
  String baseUrl;
  final Dio _dioClient;

  RestClient(String baseUrl, this._dioClient) {
    this.baseUrl = baseUrl;
  }

  Map<String, String> headers = {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "multipart/form-data"
  };

  Future<NetworkServiceResponse<T>> getAsync<T>(String endPoint,
      [Map<String, dynamic> query]) async {
    try {
      final response = await _dioClient.get(baseUrl + endPoint,
          options: Options(headers: headers), queryParameters: query);
      return processResponse<T>(response);
    } on DioError catch (e) {
      return _handleErrorDio(e);
    }
  }

  Future<NetworkServiceResponse<T>> getAsyncToken<T>(String endPoint,
      [Map<String, dynamic> query]) async {
    try {
      var token;
      await SharePrefProvider.getToken().then((result) {
        token = result;
      });
      Map<String, String> mapToken = {"Authorization": "Bearer $token"};
      headers.clear();
      headers.addAll(mapToken);
      final response = await _dioClient.get(baseUrl + endPoint,
          options: Options(headers: headers), queryParameters: query);
      return processResponse<T>(response);
    } on DioError catch (e) {
      return _handleErrorDio(e);
    }
  }

  Future<NetworkServiceResponse<T>> posyAsync<T>(String endPoint, dynamic data,
      [Map<String, dynamic> query]) async {
    try {
      FormData formData = FormData.fromMap(data);
      final response = await _dioClient.post(baseUrl + endPoint,
          options: Options(headers: headers),
          queryParameters: query,
          data: formData);

      return processResponse<T>(response);
    } on DioError catch (e) {
      return _handleErrorDio(e);
    }
  }

  Future<NetworkServiceResponse<T>> posyAsyncToken<T>(
      String endPoint, dynamic data,
      [Map<String, dynamic> query]) async {
    try {
      var token;
      await SharePrefProvider.getToken().then((result) {
        token = result;
      });
      Map<String, String> mapToken = {"Authorization": "Bearer $token"};
      headers.clear();
      headers.addAll(mapToken);
      FormData formData = FormData.fromMap(data);
      final response = await _dioClient.post(baseUrl + endPoint,
          options: Options(headers: headers),
          queryParameters: query,
          data: formData);

      return processResponse<T>(response);
    } on DioError catch (e) {
      return _handleErrorDio(e);
    }
  }

  Future<NetworkServiceResponse<T>> posyAsyncTokenRaw<T>(
      String endPoint, dynamic data,
      [Map<String, dynamic> query]) async {
    try {
      var token;
      await SharePrefProvider.getToken().then((result) {
        token = result;
      });
      Map<String, String> mapToken = {"Authorization": "Bearer $token"};
      headers.clear();
      headers.addAll(mapToken);
      final response = await _dioClient.post(baseUrl + endPoint,
          options: Options(headers: headers),
          queryParameters: query,
          data: jsonEncode(data));

      return processResponse<T>(response);
    } on DioError catch (e) {
      return _handleErrorDio(e);
    }
  }

  Future<NetworkServiceResponse<T>> posyAsyncChangePass<T>(
      String endPoint, dynamic data, String token) async {
    try {
      FormData formData = FormData.fromMap(data);
      headers.addAll({"Authorization": token});
      final response = await _dioClient.post(baseUrl + endPoint,
          options: Options(headers: headers), data: formData);

      return processResponse<T>(response);
    } on DioError catch (e) {
      return _handleErrorDio(e);
    }
  }

  NetworkServiceResponse<T> processResponse<T>(Response response) {
    if (!((response.statusCode < 200) ||
        (response.statusCode >= 300) ||
        (response.data == null))) {
      //have data
      var jsonResult;
      if (response.request.path.contains("/api/survey_submit")) {
        jsonResult = jsonDecode(response.data);
      } else {
        jsonResult = response.data;
      }
      if (jsonResult['code'] == -1) {
        //Thất bại với code từ server =-1
        throw ResponseMessageException(jsonResult['message']);
      } else {
        // if (jsonResult['data'] == null) {
        //   throw FetchDataException(jsonResult['message']);
        // } else {
        return NetworkServiceResponse<T>(
            success: true,
            data: jsonResult['data'],
            message: jsonResult['message']);
        // }
      }
    } else {
      var errorResponse = response.data;
      return NetworkServiceResponse<T>(
          success: false,
          message: "(${response.statusCode}) ${errorResponse.toString()}");
    }
  }

  Exception _handleErrorDio(DioError e) {
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        throw TimeOutFetchDataException("Connection timeout");
      case DioErrorType.RECEIVE_TIMEOUT:
        throw TimeOutFetchDataException("Receive timeout");
      case DioErrorType.SEND_TIMEOUT:
        throw TimeOutFetchDataException("Send data timeout");
      case DioErrorType.RESPONSE:
        return _responseError(e.response);
      default:
        if (e.message.contains('SocketException')) {
          throw SocketFetchException(e.message);
        } else {
          throw FetchDataException("An error happent: ${e.message}");
        }
    }
  }

  Exception _responseError(Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(response.data["message"]);
      case 401:
        throw UnauthorisedException(response.data["message"]);
      case 403:
        throw BadRequestException(response.data["message"]);
      case 500:
        throw FetchDataException("Something wrong, please try again");
      default:
        throw FetchDataException("Something wrong, please try again");
    }
  }
}
