import 'package:flutter/material.dart';

/// The `FlutterMultiTableConfig` class is used to configure the table's appearance and behavior.
/// It includes settings for headers, text styles, dropdown options, validators, and more.
class FlutterMultiTableConfig {
  /// List of column headers.
  final List<String> headers;

  /// Hint text for cells.
  final String hint;

  /// Callback to determine if a cell is read-only.
  ///
  /// Column and Row range starts from 0-5.
  ///
  /// Example usage:
  /// ```dart
  /// isReadOnly: (row, column) {
  ///   if (column == 0 || column == 1 || column == 3 || column == 4) {
  ///     return true;
  ///   }
  ///   return false;
  /// },
  /// ```
  final bool Function(int row, int column)? isReadOnly;

  /// Callback to determine if a cell should use a dropdown.
  /// Define conditions when the dropdown should be used.
  ///
  /// Column and Row range starts from 0-100.
  ///
  /// Example usage:
  /// ```dart
  /// isDropdown: (row, column) {
  ///   if (column == 2 && (row != 1 && row != 13)) {
  ///     return true;
  ///   }
  ///   return false;
  /// },
  /// ```
  final bool Function(int row, int column)? isDropdown;

  /// List of dropdown options for cells.
  ///
  /// Example usage:
  /// ```dart
  /// dropdownOptions: ['Jakarta','New York', 'London', 'Tokyo', 'Paris'],
  /// ```
  final List<String>? dropdownOptions;

  /// Callback for handling changes to cell values.
  ///
  /// Example usage:
  /// ```dart
  /// onChanged: (row, column, value) {
  ///   debugPrint('Changed: Row $row, Column $column, Value: $value');
  ///   List<Map<String, String>> updatedTableData = List.from(state.tableData);
  ///
  ///   while (row >= updatedTableData.length) {
  ///     updatedTableData.add({for (var header in state.headers) header: ''});
  ///   }
  ///
  ///   updatedTableData[row][state.headers[column]] = value;
  ///   context
  ///       .read<VehicleReportBloc>()
  ///       .add(VehicleReportEvent.tableChanged(updatedTableData));
  /// },
  /// ```
  final void Function(int row, int column, String value)? onChanged;

  /// Validator for text input cells.
  final String? Function(int row, int column, String value)? validator;

  /// Validator for dropdown cells.
  final String? Function(int row, int column, String? value)? dropdownValidator;

  /// Text style for column headers.
  final TextStyle? headerTextStyle;

  /// Background color for column headers.
  final Color? headerBoxColor;

  /// Text style for cell text.
  final TextStyle? cellTextStyle;

  /// Text style for hint text.
  final TextStyle? hintTextStyle;

  /// Text style for error messages.
  final TextStyle? errorTextStyle;

  /// Input type for text fields.
  final TextInputType? textInputType;

  /// Height of each cell.
  final double? cellHeight;

  /// Width of each cell.
  final double? cellWidth;

  /// Constructor for creating an instance of `FlutterMultiTableConfig`.
  ///
  /// This constructor allows setting various table configuration options like headers, dropdown options, text styles, etc.
  ///
  /// For portraits maximum 5 tables.
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
