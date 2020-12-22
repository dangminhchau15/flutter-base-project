
import 'package:app/datasources/app_api_provider.dart';
import 'package:app/datasources/local/share_pref_provider.dart';

class AppRepository {
  final SharePrefProvider prefs;
  final AppApiProvider appApiProvider;
  AppRepository({this.prefs, this.appApiProvider});
}