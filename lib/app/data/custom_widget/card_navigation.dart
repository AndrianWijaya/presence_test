import 'package:flutter/material.dart';
import 'package:presence_test/app/data/custom_widget/color.dart';

Container containerCustom({
  double? radiusValue,
  double? num1,
  double? num2,
  EdgeInsetsGeometry? padding,
  double? height,
  double? width,
  Color? color,
  Widget? child,
  required bool? onShadow,
  bool? useBorder = false,
  required bool? isGradient,
  required bool? useBoxDecoration,
}) {
  return Container(
    padding: padding,
    decoration: useBoxDecoration ?? true
        ? BoxDecoration(
            border: useBorder ?? true ? Border.all(
              width: 1, color: blue2, style: BorderStyle.solid
            ) : null,
            borderRadius: BorderRadius.circular(radiusValue ?? 20),
            color: color,
            gradient: isGradient ?? true
                ? LinearGradient(
                    colors: [blue2, blue1],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    stops: [num1 ?? 0, num2 ?? 0],
                  )
                : null,
            boxShadow: onShadow ?? true
                ? [
                    BoxShadow(
                      color: Color.fromRGBO(255, 255, 255, 0.30),
                      offset: const Offset(
                        0.0,
                        2.0,
                      ),
                      blurRadius: 16,
                    ),
                  ]
                : null)
        : null,
    height: height,
    width: width,
    child: child,
  );
}

ListTile listTileCustom({
  Widget? trailing,
  Widget? title,
  required bool? useIcon,
  required bool? onShadow,
  IconData? icon,
  double? size,
  Color? IconColor,
}) {
  return ListTile(
    contentPadding: EdgeInsets.only(right: 30, left: 30),
    iconColor: IconColor,
    trailing: useIcon ?? true
        ? Icon(
            icon,
            size: size,
            shadows: onShadow ?? true
                ? [
                    BoxShadow(
                      color: Color.fromRGBO(255, 255, 255, 0.20),
                      offset: const Offset(
                        0.0,
                        0.0,
                      ),
                      blurRadius: 16,
                    ),
                  ]
                : null,
          )
        : trailing,
    title: title,
  );
}

Material materialToInkWell(
    {Color? color,
    Color? colorBorder,
    required bool? useBorder,
    Widget? child,
    double? width,
    required bool? istap,
    Function()? ontap,
    double? radiusValue}) {
  return Material(
    color: color,
    shape: useBorder ?? true
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusValue ?? 20),
            side: BorderSide(
              width: width ?? 1,
              color: colorBorder ?? Colors.black,
            ),
          )
        : null,
    child: istap ?? true
        ? InkWell(
            borderRadius: BorderRadius.circular(radiusValue ?? 20),
            onTap: ontap,
            child: child,
          )
        : null,
  );
}
