import 'package:app/datasources/networks/network_service.dart';
import 'package:app/datasources/networks/network_service_response.dart';
import 'package:app/models/gold_price_response.dart';
import 'networks/rest_client.dart';

class AppApiProvider extends NetworkService {
  AppApiProvider(RestClient rest) : super(rest);
  
  Future<NetworkServiceResponse<GoldPriceResponse>> getGoldPrice() async {
    var result = await rest.getAsync("api/v1/gold");
    var data = GoldPriceResponse.fromJson(result);
    return NetworkServiceResponse(
      data: data,
      success: true
    );
  }
}