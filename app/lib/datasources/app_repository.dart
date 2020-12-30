
import 'package:app/datasources/app_api_provider.dart';
import 'package:app/datasources/local/share_pref_provider.dart';
import 'package:app/datasources/networks/network_service_response.dart';
import 'package:app/models/gold_price_response.dart';

class AppRepository {
  final SharePrefProvider prefs;
  final AppApiProvider appApiProvider;
  AppRepository({this.prefs, this.appApiProvider});

  Future<NetworkServiceResponse<List<Gold>>> getGoldPrice() => appApiProvider.getGoldPrice();
}