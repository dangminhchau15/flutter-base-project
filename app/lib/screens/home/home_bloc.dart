import 'package:app/core/base/base_bloc.dart';
import 'package:app/core/base/base_event.dart';
import 'package:app/datasources/app_api_provider.dart';
import 'package:app/datasources/exceptions/custom_exception.dart';
import 'package:app/models/gold_price_response.dart';
import 'package:app/utils/string_util.dart';
import 'package:rxdart/subjects.dart';

class HomeBloc extends BaseBLoC {
  AppApiProvider apiProvider;

  final getGoldPriceSubject = BehaviorSubject<GoldPriceResponse>();
  Stream<GoldPriceResponse> get getGoldPriceStream => getGoldPriceSubject.stream;
  Sink<GoldPriceResponse> get getGoldPriceSink => getGoldPriceSubject.sink;

  factory HomeBloc({AppApiProvider apiProvider}) {
    return HomeBloc._internal(apiProvider);
  }

  HomeBloc._internal(this.apiProvider);

  void getGoldPrice() async {
    try {
      showLoading();
      var result = await apiProvider.getGoldPrice();
      if (result.success) {
        hideLoading();
        getGoldPriceSink.add(result.data);
      } else {
        hideLoading();
        getGoldPriceSubject.addError(StringUtils.errorGetGoldPrice);
      }
    } catch (e) {
      if (e is CustomException) {
        handleExceptionWithoutLoading(e);
      }
      getGoldPriceSubject.addError(e);
    }
  }

  @override
  void dispose() {
    getGoldPriceSubject.close();
    super.dispose();
  }

  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
  }
}
