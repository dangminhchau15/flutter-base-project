import 'package:app/models/gold_price_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TableItem extends HookWidget {
  final List<GoldPriceResponse> goldPrices;

  const TableItem({Key key, @required this.goldPrices});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: useMyHook(context),
    );
  }

  useMyHook(BuildContext context) {
    return use(_TableItemContent(goldPrices: goldPrices));
  }
}

class _TableItemContent extends Hook<void> {
  final List<GoldPriceResponse> goldPrices;

  const _TableItemContent({this.goldPrices});

  @override
  _TableItemContentState createState() => _TableItemContentState();
}

class _TableItemContentState extends HookState<void, _TableItemContent> {
  @override
  Widget build(BuildContext context) {
    
  }
}
