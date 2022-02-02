import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final TextStyle? textStyle;
  final int maxLines;
  final TextAlign? textAlign;
  final bool? autoFocus;
  final int? maxLength;
  final bool? filled;
  final bool? hasBorderside;
  const CustomTextfield({
    Key? key,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.controller,
    this.textInputAction,
    this.onEditingComplete,
    this.focusNode,
    this.autoFocus = false,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.words,
    this.onChanged,
    this.maxLines = 1,
    this.filled = true,
    this.hasBorderside = true,
    this.fillColor = Colors.white,
    this.maxLength,
    this.textStyle,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign ?? TextAlign.start,
      onChanged: onChanged,
      autofocus: autoFocus!,
      cursorColor: Colors.black,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      controller: controller,
      cursorWidth: 1.0,
      maxLines: maxLines,
      obscureText: obscureText,
      maxLength: maxLength,
      validator: validator,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: !hasBorderside! ? BorderSide.none : const BorderSide(),
            borderRadius: BorderRadius.circular(8)),
        fillColor: fillColor,
        filled: true,
        hintText: hintText,
      ),
      style: textStyle ?? const TextStyle(fontSize: 16),
    );
  }
}
