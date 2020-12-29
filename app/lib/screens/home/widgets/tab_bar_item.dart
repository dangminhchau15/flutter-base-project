import 'package:app/resources/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class TabbarItem extends HookWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: useMyHook(context),
    );
  }

  useMyHook(BuildContext context) {
    return use(const _TabbarItemContent());
  }
}

class _TabbarItemContent extends Hook<void> {
  const _TabbarItemContent();

  _TabbarItemContentState createState() => _TabbarItemContentState();
}

class _TabbarItemContentState extends HookState<void, _TabbarItemContent> {
  @override
  void initHook() {
    super.initHook();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getBodyWidget();
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text("Name $index"),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.notifications_active,
                color: Colors.green,
              ),
              Text('Active')
            ],
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text("Name $index"),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Widget _getBodyWidget() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 600,
        isFixedHeader: false,
        headerWidgets: null,
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: 10,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: AppColor.colorPrimary,
        rightHandSideColBackgroundColor: AppColor.colorPrimary
      ),
      height: MediaQuery.of(context).size.height,
    );
  }
}
