import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final Color? color;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  const CustomButton(
      {Key? key,
      this.onPressed,
      this.textStyle,
      this.text,
      this.color,
      this.child,
      this.width = 250,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width,
      child: MaterialButton(
        onPressed: onPressed,
        child: child ??
            Text(text!,
                style: textStyle ?? const TextStyle(color: Colors.white)),
        color: color,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: color ?? Colors.grey.shade300)),
      ),
    );
  }
}
