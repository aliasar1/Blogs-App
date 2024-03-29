import 'package:blogs_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomSearchWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmit;

  const CustomSearchWidget(
      {Key? key, this.controller, this.validator, this.onFieldSubmit})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchWidgetState createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Constants.whiteColor.withOpacity(0.8),
      ),
      child: TextFormField(
        cursorColor: Constants.secondaryColor,
        controller: widget.controller,
        onFieldSubmitted: widget.onFieldSubmit,
        onChanged: widget.onFieldSubmit,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(color: Constants.primaryColor),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Constants.secondaryColor,
          ),
          hintText: 'Search for...',
          hintStyle: TextStyle(color: Constants.primaryColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
