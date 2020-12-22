
import 'package:app/datasources/networks/rest_client.dart';

abstract class NetworkService {
  RestClient rest;
  NetworkService(this.rest);
}
