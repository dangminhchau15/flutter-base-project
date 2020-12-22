import 'package:app/datasources/networks/network_service_response.dart';

enum ApiType { login }

class FetchProcess<T> {
  ApiType type;
  String title;
  bool loading;
  NetworkServiceResponse<T> response;

  FetchProcess({this.loading, this.response, this.type});
}
