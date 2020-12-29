import 'package:app/resources/values/colors.dart';
import 'package:app/resources/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef ChangeValue(String itemValue);

class Combobox<T> extends HookWidget {
  final List<T> data;
  final Size size;
  final double width;
  final T itemValue;
  final BuildContext context;
  final ChangeValue changeValue;

  const Combobox(
      {Key key,
      this.data,
      this.size,
      this.width,
      this.itemValue,
      this.context,
      this.changeValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _combobox(data, size, width, itemValue, context, changeValue);
  }

  Widget _combobox<T>(List<T> data, Size size, double width, T itemValue,
      BuildContext context, ChangeValue changeValue) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColor.colorsBorderOutline,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(AppDimen.border),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: AppDimen.kDefaultPadding - 8,
              bottom: AppDimen.kDefaultPadding - 8),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField(
                decoration: InputDecoration.collapsed(hintText: ''),
                value: itemValue,
                items: data.map<DropdownMenuItem<T>>((T value) {
                  return DropdownMenuItem<T>(
                    value: value,
                    child: Text(
                      "$value",
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  changeValue(value);
                },
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
        ));
  }
}
