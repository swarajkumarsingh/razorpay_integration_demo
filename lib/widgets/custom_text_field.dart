import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  final String text;
  final TextInputType textInputType;
  final TextEditingController controller;
  const NameTextField({
    Key? key,
    required this.text,
    this.textInputType = TextInputType.name,
    required this.controller,
  }) : super(key: key);

  final double height = 40;
  final int nameMinLength = 3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        validator: (value) {
          if (value!.isNotEmpty && value.length >= nameMinLength) {
            return null;
          } else if (value.isEmpty) {
            return "Please enter a value";
          } else if (value.length < nameMinLength) {
            return "Invalid Field Value";
          } else {
            return "Invalid Value";
          }
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintText: text,
          fillColor: const Color.fromARGB(255, 223, 220, 220),
          filled: true,
        ),
      ),
    );
  }
}
