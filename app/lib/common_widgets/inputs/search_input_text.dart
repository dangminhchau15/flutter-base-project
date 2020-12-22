import 'package:app/resources/values/colors.dart';
import 'package:app/resources/values/dimens.dart';
import 'package:app/resources/values/fonts.dart';
import 'package:flutter/material.dart';

typedef OnSearchListener();

class SearchInputText extends StatefulWidget {
  final OnSearchListener onSearchListener;

  SearchInputText({this.onSearchListener});

  @override
  _SearchInputTextState createState() => _SearchInputTextState();
}

class _SearchInputTextState extends State<SearchInputText> {
  OnSearchListener _onSearchListener;

  @override
  void initState() {
    super.initState();
    _onSearchListener = widget.onSearchListener;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: AppColor.grey,
            ),
            onPressed: () {
              _onSearchListener();
            },
          ),
        ),
        Text(
          "Tìm kiếm thông tin",
          style: TextStyle(
              fontSize: AppDimen.normal,
              fontFamily: FontsNames.textRegular,
              color: AppColor.grey),
        )
      ],
    );
  }
}
