import 'package:dentilligence/constance/colors_constance.dart';
import 'package:dentilligence/constance/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int? maxLength;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool isPreFilled; // Indicates if the field is pre-filled
  final bool autoValidate; // Controls whether to auto-validate
  final void Function(String)? onChanged; // Add onChanged callback

  const CustomField({
    required this.labelText,
    required this.controller,
    required this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.readOnly = false,
    this.isPreFilled = false,
    this.autoValidate = false, // Default to false
    this.onChanged, // Add onChanged parameter
    Key? key,
  }) : super(key: key);

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  late FocusNode _focusNode;
  bool _isUserEdited = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });

    // Initialize _isUserEdited based on isPreFilled
    _isUserEdited = !widget.isPreFilled;

    // Listen for manual changes (user edits)
    widget.controller.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _isUserEdited = true; // Mark as edited once user types
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormField<String>(
          validator: (value) {
            // Only validate if the user has edited the field or autoValidate is true
            if ((_isUserEdited || widget.autoValidate) && widget.validator != null) {
              return widget.validator!(widget.controller.text);
            }
            return null;
          },
          builder: (FormFieldState<String> field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLines,
                  focusNode: _focusNode,
                  readOnly: widget.readOnly,
                  decoration: InputDecoration(
                    labelText: widget.labelText,
                    labelStyle: GoogleFonts.kanit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: _focusNode.hasFocus
                          ? ColorsConstants.textPrimaryColor
                          : ColorsConstants.textSecondaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    counterText: "",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: ColorsConstants.textPrimaryColor,
                        width: 1.w,
                      ),
                    ),
                    suffixIcon: widget.suffixIcon,
                    prefixIcon: widget.prefixIcon,
                    errorText: field.errorText,
                  ),
                  style: widget.readOnly
                      ? TextStyle(color: ColorsConstants.textSecondaryColor)
                      : TextStyles.blackText,
                  cursorColor: ColorsConstants.textPrimaryColor,
                  onChanged: (value) {
                    field.didChange(value); // Notify FormField of changes
                    if (widget.onChanged != null) {
                      widget.onChanged!(value); // Call the onChanged callback
                    }
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class CustomDropdownField<T> extends StatefulWidget {
  final String labelText;
  final List<T> items; // Generic list of items
  final T? selectedValue; // Programmatically set value
  final Function(T?) onChanged; // Callback when user selects an option
  final String Function(T) displayText; // Convert item to display text
  final String? Function(T?)? validator;

  const CustomDropdownField({
    required this.labelText,
    required this.items,
    this.selectedValue,
    required this.onChanged,
    required this.displayText,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  _CustomDropdownFieldState<T> createState() => _CustomDropdownFieldState<T>();
}

class _CustomDropdownFieldState<T> extends State<CustomDropdownField<T>> {
  late T? _selectedValue;
  // bool _isUserEdited = false; // Tracks if user made a selection
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;

    // Focus listener to detect dropdown focus changes
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  // @override
  // void didUpdateWidget(covariant CustomDropdownField<T> oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   // If selectedValue changes programmatically, reset _isUserEdited
  //   if (widget.selectedValue != oldWidget.selectedValue) {
  //     setState(() {
  //       _selectedValue = widget.selectedValue;
  //       _isUserEdited = false; // No user interaction yet
  //     });
  //   }
  // }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormField<T>(
          validator: (value) {
            if (widget.validator != null) {
              return widget.validator!(value);
            }
            return null;
          },
          builder: (FormFieldState<T> field) {
            return DropdownButtonFormField<T>(
              focusNode: _focusNode,
              value: _selectedValue,
              decoration: InputDecoration(
                labelText: widget.labelText,
                labelStyle: GoogleFonts.kanit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: _focusNode.hasFocus
                      ? ColorsConstants.textPrimaryColor
                      : ColorsConstants.textSecondaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: ColorsConstants.textPrimaryColor,
                    width: 1.w,
                  ),
                ),
                errorText: field.errorText,
              ),
              dropdownColor: Colors.white,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: ColorsConstants.textPrimaryColor,
                size: 24,
              ),
              items: widget.items.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    widget.displayText(item),
                    style: GoogleFonts.kanit(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (T? newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
                widget.onChanged(newValue);
                field.didChange(newValue);
              },
            );
          },
        ),
      ],
    );
  }
}
