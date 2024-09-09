// File: lib/src/flutter_multi_table_controller.dart

import 'package:flutter/material.dart';

class FlutterMultiTableController {
  List<Map<String, TextEditingController>> tableData;
  final Map<String, String?> _dropdownErrors = {};

  FlutterMultiTableController(
      {required List<Map<String, String>> initialData,
      required List<String> headers})
      : tableData = initialData.map((row) {
          return {
            for (String header in headers)
              header: TextEditingController(text: row[header] ?? '')
          };
        }).toList();

  void updateCell(int row, int column, String value) {
    if (row < tableData.length && column < tableData[row].length) {
      tableData[row].values.elementAt(column).text = value;
    }
  }

  String? getCellValue(int row, int column) {
    if (row < tableData.length && column < tableData[row].length) {
      return tableData[row].values.elementAt(column).text;
    }
    return null;
  }

  void setDropdownError(int row, int column, String? error) {
    _dropdownErrors['$row-$column'] = error;
  }

  String? getDropdownError(int row, int column) {
    return _dropdownErrors['$row-$column'];
  }

  void dispose() {
    for (var row in tableData) {
      for (var controller in row.values) {
        controller.dispose();
      }
    }
  }
}
