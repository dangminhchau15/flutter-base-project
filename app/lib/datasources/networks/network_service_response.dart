import 'package:app/datasources/exceptions/custom_exception.dart';

class NetworkServiceResponse<T> extends CustomException {
  T data;
  bool success;
  String message;

  NetworkServiceResponse({this.data, this.success, this.message});
}