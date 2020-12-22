import 'package:app/config/service_locator.dart';
import 'package:app/datasources/app_api_provider.dart';
import 'package:app/datasources/networks/rest_client.dart';
import 'package:dio/dio.dart';

enum Flavor { DEV, RELEASE }

//Simple DI
class Injector {
  String baseUrlDev = "https://test-synthetic-news.vn";
  String baseUrlRelease = "https://test-synthetic-news.vn";
  static final Injector _singleton = Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) async {
    _flavor = flavor;
  }

  factory Injector() => _singleton;

  Injector._internal();

  AppApiProvider get apiService {
    print(_flavor);
    switch (_flavor) {
      case Flavor.DEV:
        return AppApiProvider(RestClient(baseUrlDev, locator<Dio>()));
      default:
        return AppApiProvider(RestClient(baseUrlRelease, locator<Dio>()));
    }
  }

  String get url {
    switch (_flavor) {
      case Flavor.DEV:
        return baseUrlDev;
      default:
        return baseUrlRelease;
    }
  }
}
