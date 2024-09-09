import 'package:flutter/material.dart';

class FlutterMultiTableConfig {
  final List<String> headers;
  final String hint;
  final bool Function(int row, int column)? isReadOnly;
  final bool Function(int row, int column)? isDropdown;
  final List<String>? dropdownOptions;
  final void Function(int row, int column, String value)? onChanged;
  final String? Function(int row, int column, String value)? validator;
  final String? Function(int row, int column, String? value)? dropdownValidator;
  final TextStyle? headerTextStyle;
  final Color? headerBoxColor;
  final TextStyle? cellTextStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? errorTextStyle;
  final TextInputType? textInputType;
  final double? cellHeight;
  final double? cellWidth;

  FlutterMultiTableConfig({
    required this.headers,
    this.hint = "",
    this.isReadOnly,
    this.isDropdown,
    this.dropdownOptions,
    this.onChanged,
    this.validator,
    this.dropdownValidator,
    this.headerTextStyle,
    this.headerBoxColor,
    this.cellTextStyle,
    this.hintTextStyle,
    this.errorTextStyle,
    this.textInputType,
    this.cellHeight,
    this.cellWidth,
  });
}
