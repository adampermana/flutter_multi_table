/*============================================================
 Module Name       : flutter_multi_table_controller.dart
 Date of Creation  : 2024/08/03
 Name of Creator   : Adam Permana
 History of Modifications:
 2024/08/03 - Initial creation of the FlutterMultiTableController class.

 Summary           : Controller class to manage data, updates, validation,
                     and error handling for a Flutter multi-table widget.

 Functions         :
 - updateCell(int row, int column, String value): Updates a specific cell's value
 - getCellValue(int row, int column): Retrieves the value of a specific cell
 - setDropdownError(int row, int column, String? error): Sets error message for dropdown cells
 - getDropdownError(int row, int column): Retrieves error message for dropdown cells
 - dispose(): Disposes all TextEditingController instances

 Variables         :
 - List<Map<String, TextEditingController>> tableData: Holds the data for the table cells
 - Map<String, String?> _dropdownErrors: Tracks errors for dropdown cells

 ============================================================*/

// File: lib/src/flutter_multi_table_controller.dart

import 'package:flutter/material.dart';

/// The `FlutterMultiTableController` class is used to manage table data.
/// It provides methods to set, update, and retrieve cell values,
/// and handle validation and errors for dropdown fields.
class FlutterMultiTableController {
  /// A list of table data where each entry is a map containing a TextEditingController for each header.
  List<Map<String, TextEditingController>> tableData;

  /// A private map to track errors for dropdown fields, with 'row-column' combination as the key.
  final Map<String, String?> _dropdownErrors = {};

  /// Constructor for creating an instance of `FlutterMultiTableController`.
  ///
  /// [initialData] is a list of maps containing the initial table data.
  /// [headers] is a list of column headers used in the table.
  ///
  /// initialData and headers must be the same and match in value.
  ///
  /// Example usage:
  /// ```dart
  /// List<String> headers = [
  ///   'No',
  ///   'Name',
  ///   'Age',
  ///   'City',
  ///   'Status',
  /// ];
  /// List<Map<String, String>> initialData = [
  ///   {
  ///     'No': '1',
  ///     'Name': 'John',
  ///     'Age': '',
  ///     'City': 'New York',
  ///     'Status': 'Active',
  ///   },
  ///   {
  ///     'No': '2',
  ///     'Name': 'Alice',
  ///     'Age': '',
  ///     'City': 'London',
  ///     'Status': 'Inactive',
  ///   },
  /// ];
  /// ```
  FlutterMultiTableController({
    required List<Map<String, String>> initialData,
    required List<String> headers,
  }) : tableData = initialData.map((row) {
          return {
            for (String header in headers)
              header: TextEditingController(text: row[header] ?? '')
          };
        }).toList();

  /// Updates the value of a specific cell in the table.
  ///
  /// [row] is the row index of the cell.
  /// [column] is the column index of the cell.
  /// [value] is the new value to be set in the cell.
  void updateCell(int row, int column, String value) {
    if (row < tableData.length && column < tableData[row].length) {
      tableData[row].values.elementAt(column).text = value;
    }
  }

  /// Retrieves the value of a specific cell in the table.
  ///
  /// [row] is the row index of the cell.
  /// [column] is the column index of the cell.
  /// Returns the cell value if found; otherwise, returns `null`.
  String? getCellValue(int row, int column) {
    if (row < tableData.length && column < tableData[row].length) {
      return tableData[row].values.elementAt(column).text;
    }
    return null;
  }

  /// Sets an error message for a dropdown cell.
  ///
  /// [row] is the row index of the dropdown cell.
  /// [column] is the column index of the dropdown cell.
  /// [error] is the error message to be set, or `null` to clear any existing error.
  void setDropdownError(int row, int column, String? error) {
    _dropdownErrors['$row-$column'] = error;
  }

  /// Retrieves the error message for a dropdown cell.
  ///
  /// [row] is the row index of the dropdown cell.
  /// [column] is the column index of the dropdown cell.
  /// Returns the error message if found; otherwise, returns `null`.
  String? getDropdownError(int row, int column) {
    return _dropdownErrors['$row-$column'];
  }

  /// Disposes of all `TextEditingController` instances used in the table.
  /// This method should be called to free up resources when the table is no longer needed.
  void dispose() {
    for (var row in tableData) {
      for (var controller in row.values) {
        controller.dispose();
      }
    }
  }
}
