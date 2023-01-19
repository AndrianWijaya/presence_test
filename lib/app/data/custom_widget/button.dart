import 'package:flutter/material.dart';

ElevatedButton elevatedButtonCustome({
  Function()? onPressed,
  Widget? child,
  double? radiusValue,
  bool? useBorderRadius,
}) {
  return  ElevatedButton(
    onPressed: onPressed,
    child: child,
    style: ElevatedButton.styleFrom(
        shape: useBorderRadius ?? true ? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusValue?? 20)
        ) : null,
        backgroundColor: Colors.transparent,
        disabledForegroundColor: Colors.transparent,
        shadowColor: Colors.transparent),
  );
}
