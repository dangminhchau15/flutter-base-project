import 'package:app/common_widgets/inputs/search_input_text.dart';
import 'package:app/resources/values/colors.dart';
import 'package:flutter/material.dart';

class SearchInputHeader extends StatefulWidget {
  @override
  _SearchInputHeaderState createState() => _SearchInputHeaderState();
}

class _SearchInputHeaderState extends State<SearchInputHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: AppColor.colorPrimary),
      child: Row(
        children: [
          Flexible(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(color: Colors.white, child: SearchInputText()),
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.drag_indicator_rounded),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
