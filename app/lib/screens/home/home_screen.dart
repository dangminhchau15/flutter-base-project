import 'package:app/resources/values/colors.dart';
import 'package:app/screens/home/widgets/search_input_header.dart';
import 'package:app/screens/home/widgets/tab_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchInputHeader(),
        DefaultTabController(
          length: 3,
          child: Container(
            height: ScreenUtil().setHeight(564),
            child: Scaffold(
              appBar: TabBar(
                labelColor: AppColor.colorPrimary,
                unselectedLabelColor: AppColor.grey,
                indicatorColor: AppColor.colorPrimary,
                tabs: [
                  Tab(
                    text: "Giá vàng",
                  ),
                  Tab(
                    text: "Giá vàng",
                  ),
                  Tab(
                    text: "Giá vàng",
                  ),
                ],
              ),
              body: TabBarView(
                children: [
                  TabbarItem(),
                  Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
