import 'package:app/datasources/app_repository.dart';
import 'package:app/datasources/local/share_pref_provider.dart';
import 'package:app/di/env.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

void setupLocator() async {
  //Provide SharedPreferenceHelper
  locator.registerLazySingleton(() {
    return SharePrefProvider(SharedPreferences.getInstance());
  });

  //Provide AppRepository
  locator.registerLazySingleton(() {
    var prefs = locator<SharePrefProvider>();
    final appApiProvider = Injector().apiService;
    // var apiClient = locator<ApiClient>();
    return AppRepository(prefs: prefs, appApiProvider: appApiProvider);
  });
}