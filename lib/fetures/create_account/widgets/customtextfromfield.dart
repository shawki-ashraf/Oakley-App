import 'package:flutter/material.dart';

class Customtextfromfield extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Widget? suffix;
  final bool obscure;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // ✅ validation
  final TextInputType? keyboardType; // ✅ نوع الكيبورد
  final Function(String)? onChanged; // ✅ اختياري

  const Customtextfromfield({
    super.key,
    required this.hint,
    required this.icon,
    this.suffix,
    required this.obscure,
    this.controller,
    this.validator,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
