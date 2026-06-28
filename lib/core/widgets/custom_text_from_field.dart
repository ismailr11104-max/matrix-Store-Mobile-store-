import 'package:flutter/material.dart';
import 'package:matrix_app/core/constants/app_sized.dart';

class CustomTextFromField extends StatefulWidget {
  const CustomTextFromField({
    super.key,
    required this.controller,
    this.maxLines,
    required this.hintText,
    required this.title,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final int? maxLines;
  final String hintText;
  final String title;
  final Widget? suffixIcon;
  final bool obscureText;
  final Function(String? value)? validator;

  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {
  bool _isVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: AppSized.sp14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        SizedBox(height: AppSized.h8),
        SizedBox(
          width: double.infinity,
          height: AppSized.h56,
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator != null
                ? (String? value) => widget.validator!(value)
                : null,
            obscureText: widget.obscureText && !_isVisibility,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: AppSized.sp16,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSized.w14,
                vertical: AppSized.h14,
              ),
              suffixIcon: widget.obscureText
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisibility = !_isVisibility;
                        });
                      },
                      icon: Icon(
                        _isVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Color(0xFF9CA3AF),
                      ),
                    )
                  : null,
            ),
            cursorColor: Color(0xFF9CA3AF),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
