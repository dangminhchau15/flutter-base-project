import 'dart:async';

import 'package:app/core/base/base_event.dart';
import 'package:app/core/loading/fetch_process.dart';
import 'package:app/datasources/exceptions/custom_exception.dart';
import 'package:app/datasources/networks/network_service_response.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBLoC {
  FetchProcess process;
  PublishSubject<FetchProcess> _loadingStreamController =
      PublishSubject<FetchProcess>();

  StreamController<BaseEvent> _processEventSubject =
      BehaviorSubject<BaseEvent>();

  StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  PublishSubject<CustomException> _handleExceptionController =
      PublishSubject<CustomException>();

  Sink<BaseEvent> get event => _eventStreamController.sink;

  Stream<FetchProcess> get loadingStream => _loadingStreamController.stream;
  Sink<FetchProcess> get loadingSink => _loadingStreamController.sink;

  Stream<BaseEvent> get processEventStream => _processEventSubject.stream;
  Sink<BaseEvent> get processEventSink => _processEventSubject.sink;

  //showmesage
  Stream<CustomException> get handleExceptionStream =>
      _handleExceptionController.stream;
  Sink<CustomException> get handleExceptionSink =>
      _handleExceptionController.sink;

  BaseBLoC() {
    process = FetchProcess();
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) {
        throw Exception("Invalid event");
      }
      dispatchEvent(event);
    });
  }

  void showLoading({String title = "Loading..."}) {
    process.loading = true;
    process.title = title;
    _loadingStreamController.add(process);
  }

  void hideLoading({NetworkServiceResponse<dynamic> result}) {
    process.loading = false;
    process.response = result;
    _loadingStreamController.add(process);
  }

  void dispatchEvent(BaseEvent event);

  void dispose() {
    _eventStreamController.close();
    _loadingStreamController.close();
    _processEventSubject.close();
    _handleExceptionController.close();
  }

  void handleExceptionWithoutLoading(e) {
    handleExceptionSink.add(e);
  }
}
