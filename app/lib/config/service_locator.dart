import 'package:app/config/cs_log_interceptor.dart';
import 'package:app/datasources/app_repository.dart';
import 'package:app/datasources/local/share_pref_provider.dart';
import 'package:app/di/env.dart';
import 'package:app/screens/home/home_bloc.dart';
import 'package:dio/dio.dart';
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

  locator.registerLazySingleton<HomeBloc>(() {
    return HomeBloc(userRepository: locator<AppRepository>());
  });

  //Provide Dio
  locator.registerLazySingleton(() {
    return Dio(BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ))
      ..interceptors.add(CSLogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (object) {
            if (object == null || (object as String) == "null") {
              return;
            }
            print(object);
          }));
  });
}
