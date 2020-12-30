import 'package:app/resources/values/colors.dart';
import 'package:app/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      child: MaterialApp(
        title: "Chợ Giá",
        home: MainScreen(),
      ),
    );
  }
}
