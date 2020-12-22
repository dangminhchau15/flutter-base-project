import 'package:app/datasources/networks/network_service.dart';
import 'package:app/datasources/networks/rest_client.dart';

class AppApiProvider extends NetworkService {
  AppApiProvider(RestClient rest) : super(rest);
}