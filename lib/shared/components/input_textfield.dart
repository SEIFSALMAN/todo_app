
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.descriptionController,
  });

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          style: TextStyle(color: Colors.black),
          cursorColor: Colors.black,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Please enter your description task";
            } else {
              return null;
            }
          },
          maxLines: 3,
          controller: descriptionController,
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: "Add your description here.",
              hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 15,
                  )),
        ));
  }
}
