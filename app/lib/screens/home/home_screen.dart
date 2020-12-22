import 'package:app/resources/values/colors.dart';
import 'package:app/screens/home/widgets/search_input_header.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchInputHeader(),
        DefaultTabController(
            length: 3,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 100),
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
                    Icon(Icons.access_alarms),
                    Icon(Icons.directions_transit),
                    Icon(Icons.directions_bike),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
