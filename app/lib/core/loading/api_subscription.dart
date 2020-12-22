import 'package:app/common_widgets/dialogs/common_dialogs.dart';
import 'package:app/core/loading/fetch_process.dart';
import 'package:app/datasources/exceptions/custom_exception.dart';
import 'package:flutter/material.dart';

apiSubscription(Stream<FetchProcess> apiResult, BuildContext context) {
  apiResult.listen((FetchProcess p) {
    if (p.loading) {
      showProgress(context, p?.title);
    } else {
      hideProgress(context);
    }
  });
}

handleException(Stream<CustomException> apiResult, BuildContext context) {
  apiResult.listen((CustomException e) {
    switch (e.runtimeType) {
      case UnauthorisedException:
        showWarningMessage(
            context, "Phiên bản đăng nhập hết hạn!\nVui lòng đăng nhập lại!",
            () {
          Navigator.pop(context);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        });
        break;

      case SocketFetchException:
        showWarningMessage(context, "Mất kết nối mạng vui lòng thử lại sau!",
            () {
          Navigator.pop(context);
        });
        break;
      default:
        showWarningMessage(context, "${e.message}", () {
          Navigator.pop(context);
        });
        break;
    }
  });
}