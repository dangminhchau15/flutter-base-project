import 'package:app/common_widgets/dialogs/ldialog.dart';
import 'package:app/resources/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

typedef OnPressButtonOK();

void showWarningMessage(
    BuildContext context, String message, VoidCallback positiveTap) {
  showDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      barrierDismissible: true,
      builder: (context) => LDialog(
            primaryColor: AppColor.warning,
            positiveTap: positiveTap,
            icon: Icon(Icons.check),
            title: Text('Thông báo'),
            content: Text(message ?? ''),
          ));
}

showProgress(BuildContext context, String title) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitWave(
              color: Theme.of(context).primaryColor,
            ),
            Text(title != null ? title : "",
                style: TextStyle(color: Colors.white, fontSize: 16))
          ],
        ),
      ),
    ),
  );
}

hideProgress(BuildContext context) {
  Navigator.pop(context);
}