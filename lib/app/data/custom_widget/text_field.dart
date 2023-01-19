import 'package:flutter/material.dart';
import 'package:presence_test/app/data/custom_widget/color.dart';

TextField textField(
    {String? labelText,
    String? hintText,
    Widget? label,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? textStyle,
    bool? autocorrect,
    bool? readOnly,
    bool? enabled,
    bool? isDefaultFillColor = true,
    bool? isDefaultIconColor = true,
    Color? cursorColor,
    Color? fillColor,
    Color? iconColor,
    bool? isIconPrefixOn,
    BorderSide? borderSide,
    BorderSide? enabledBorderSide,
    BorderSide? focusedBorder,
    TextInputType? keyboardType,
    TextEditingController? controller,
    required bool obscureText,
    required bool isIconOn,
    Function()? onPressed,
    Icon? icon}) {
  return TextField(
    style: textStyle,
    cursorColor: cursorColor,
    readOnly: readOnly ?? false,
    enabled: enabled ?? true,
    keyboardType: keyboardType,
    autocorrect: autocorrect ?? false,
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      fillColor: isDefaultFillColor ?? true ? Colors.white : fillColor,
      filled: true,
      labelStyle: labelStyle,
      label: label,
      hintText: hintText,
      hintStyle: hintStyle,
      labelText: labelText,
      border: isIconPrefixOn ?? true  ? isIconOn == false
          ? OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: borderSide ?? BorderSide())
          : OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: borderSide ?? BorderSide())
          : OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: borderSide ?? BorderSide()),
      enabledBorder: isIconPrefixOn ?? true ? isIconOn == false
          ? OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: enabledBorderSide ?? BorderSide())
          : OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: enabledBorderSide ?? BorderSide())
          : OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: enabledBorderSide ?? BorderSide()),
      focusedBorder: isIconPrefixOn ?? true  ? isIconOn == false
          ? OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: focusedBorder ?? BorderSide())
          : OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: focusedBorder ?? BorderSide())
          : OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: focusedBorder ?? BorderSide()),
      prefixIcon: isIconPrefixOn ?? true ? icon : null,
      suffixIcon: isIconOn
          ? IconButton(
              color: isDefaultIconColor ?? true ? blue2 : iconColor,
              icon: obscureText
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
              onPressed: onPressed)
          : null,
    ),
  );
}
