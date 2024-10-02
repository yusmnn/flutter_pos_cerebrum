import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({
    super.key,
    required this.controller,
    required this.label,
    this.onChanged,
    required this.obscureText,
    this.keyboardType,
    this.capizalize,
    required this.showLabel,
    this.suffixIcon,
    this.prefixIcon,
    this.color,
    this.readOnly,
  });

  final Function(String value)? onChanged;
  final TextCapitalization? capizalize;
  final Color? color;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String label;
  final bool obscureText;
  final bool? readOnly;
  final bool showLabel;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: TextFormField(
        readOnly: readOnly ?? false,
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textCapitalization: capizalize ?? TextCapitalization.words,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          labelStyle: TextStyle(
            color: color ?? AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: AppColors.grey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
