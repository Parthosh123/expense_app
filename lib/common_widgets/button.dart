import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  double? fontSize;
  double? minWidth;
  double? minHeight;
  final double? curveValue;
  final Function()? press;
  Color? color;
  Widget? child;

  OutlinedButtonWidget({
    Key? key,
    this.fontSize,
    this.minWidth,
    this.minHeight,
    this.press,
    this.curveValue,
    this.color,
    this.child,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: minWidth != null ? Size(minWidth!, minHeight!) : null,
        shadowColor: Colors.transparent,
        shape: curveValue != null
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  curveValue!,
                ),
              )
            : null,
        // side: BorderSide(width: 10.0, color: Colors.blue),
      ),
      child: child,
      onPressed: press,
    );
  }
}
