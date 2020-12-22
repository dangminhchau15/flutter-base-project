import 'package:flutter/material.dart';

class LDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final VoidCallback positiveTap;
  final VoidCallback negativeTap;
  final Widget positiveText;
  final Widget negativeText;
  final Color primaryColor;
  final Widget icon;

  LDialog({
    Key key,
    this.title,
    this.content,
    this.positiveTap,
    this.negativeTap,
    this.positiveText,
    this.negativeText,
    this.primaryColor = Colors.blue,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[_buildContent(), _buildCenterCircle()],
      ),
    );
  }

  Widget _buildButton() {
    if (positiveTap == null && negativeTap == null) return null;
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 80.0,
          child: Row(
            children: <Widget>[
              (negativeTap != null)
                  ? Expanded(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        onPressed: negativeTap,
                        child: DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                          child: negativeText ?? Text('Huỷ'),
                        ),
                      ),
                    )
                  : null,
              SizedBox(width: 8.0),
              (positiveTap != null)
                  ? Expanded(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        color: primaryColor ?? Colors.blue,
                        onPressed: positiveTap,
                        child: DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          child: positiveText ?? Text('OK'),
                        ),
                      ),
                    )
                  : null
            ].where((element) => element != null).toList(),
          ),
        );
      },
    );
  }

  Widget _buildCenterCircle() {
    var centerCircleSize = 56.0;
    return Positioned(
      left: 0.0,
      right: 0.0,
      top: -(centerCircleSize / 2),
      child: Container(
        child: CircleAvatar(
            child: icon ?? Icon(Icons.info_outline),
            foregroundColor: Colors.white,
            backgroundColor: primaryColor ?? Colors.blue),
        width: centerCircleSize,
        height: centerCircleSize,
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF), // border color
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      width: 482,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildTitle(),
          (title != null) ? SizedBox(height: 12.0) : null,
          _buildMessage(),
          SizedBox(height: 12.0),
          _buildButton()
        ].where((element) => element != null).toList(),
      ),
    );
  }

  Widget _buildTitle() {
    if (title == null) return null;
    return DefaultTextStyle(
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 19.0, fontWeight: FontWeight.bold, color: Colors.black87),
      child: title,
    );
  }

  Widget _buildMessage() {
    if (content == null) return null;
    return ConstrainedBox(
      constraints: new BoxConstraints(
        minHeight: 60.0,
        maxHeight: 100.0,
      ),
      child: Center(
        child: Container(
          child: SingleChildScrollView(
                  child: DefaultTextStyle(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
