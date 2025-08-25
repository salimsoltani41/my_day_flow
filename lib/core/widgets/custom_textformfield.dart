import 'package:flutter/material.dart';
import 'package:my_day_flow/core/constants/colors.dart';

class MyTextFormField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final IconData? suffixIcon;
  final void Function()? onPressedSuffix;
  final TextInputType? textType;
  final bool? obfuscate;

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const MyTextFormField({
    super.key,
    required this.hint,
    this.controller,
    this.validator,
    required this.icon,
    this.suffixIcon,
    this.onPressedSuffix,
    this.textType,
    this.obfuscate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        obscureText: obfuscate ?? false,
        keyboardType: textType,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          errorStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 254, 96, 85),
          ),
          hintStyle: TextStyle(color: AppColors.darkGrey),
          hintText: hint,

          suffixIcon: IconButton(
            onPressed: onPressedSuffix,
            icon: Icon(size: 28, suffixIcon, color: AppColors.blue),
          ),
          prefixIcon: Icon(size: 32, icon, color: AppColors.blue),
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
