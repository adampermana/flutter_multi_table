import 'package:flutter/material.dart';
import 'package:flutter_multi_table/flutter_multi_table.dart';

class FlutterMultiTable extends StatefulWidget {
  final FlutterMultiTableController controller;
  final FlutterMultiTableConfig config;

  const FlutterMultiTable({
    Key? key,
    required this.controller,
    required this.config,
  }) : super(key: key);

  @override
  _FlutterMultiTableState createState() => _FlutterMultiTableState();
}

class _FlutterMultiTableState extends State<FlutterMultiTable> {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: {
        for (int i = 0; i < widget.config.headers.length; i++)
          i: widget.config.cellWidth != null
              ? FixedColumnWidth(widget.config.cellWidth!)
              : const FlexColumnWidth(),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.rectangle,
          ),
          children: widget.config.headers
              .map((header) => _buildHeaderCell(header))
              .toList(),
        ),
        ...widget.controller.tableData.asMap().entries.map((entry) {
          int rowIndex = entry.key;
          Map<String, TextEditingController> row = entry.value;
          return TableRow(
            children: row.entries.map((cellEntry) {
              int columnIndex = widget.config.headers.indexOf(cellEntry.key);
              return _buildEditableCell(rowIndex, columnIndex, cellEntry.value);
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: widget.config.headerTextStyle ??
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildEditableCell(
      int row, int column, TextEditingController controller) {
    bool isReadOnly = widget.config.isReadOnly?.call(row, column) ?? false;
    bool isDropdown = widget.config.isDropdown?.call(row, column) ?? false;

    if (isDropdown) {
      return _buildDropdownCell(row, column, controller, isReadOnly);
    } else {
      return _buildTextFieldCell(row, column, controller, isReadOnly);
    }
  }

  Widget _buildDropdownCell(
      int row, int column, TextEditingController controller, bool isReadOnly) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 1.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              style: const TextStyle(color: Colors.black),
              alignment: Alignment.center,
              icon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 14,
                color: Colors.black54,
              ),
              isExpanded: true,
              value: controller.text.isNotEmpty ? controller.text : null,
              hint: Text(
                widget.config.hint,
                textAlign: TextAlign.center,
              ),
              onChanged: isReadOnly
                  ? null
                  : (value) {
                      setState(() {
                        controller.text = value!;
                        widget.config.onChanged?.call(row, column, value);
                        String? error = widget.config.dropdownValidator
                            ?.call(row, column, value);
                        widget.controller.setDropdownError(row, column, error);
                      });
                    },
              items:
                  widget.config.dropdownOptions?.map<DropdownMenuItem<String>>(
                (option) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.center,
                    value: option,
                    child: Text(
                      option,
                      style: const TextStyle(
                          fontSize: 7, fontWeight: FontWeight.w400),
                    ),
                  );
                },
              ).toList(),
              validator: (value) {
                if (!isReadOnly) {
                  return widget.config.dropdownValidator
                      ?.call(row, column, value);
                }
                return null;
              },
              decoration: InputDecoration(
                errorText: widget.controller.getDropdownError(row, column),
                errorStyle: widget.config.errorTextStyle ??
                    const TextStyle(color: Colors.red, fontSize: 12),
                border: InputBorder.none,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldCell(
      int row, int column, TextEditingController controller, bool isReadOnly) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 1.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: widget.config.cellHeight ?? 40.0,
            minWidth: widget.config.cellWidth ?? 100.0,
          ),
          child: IntrinsicHeight(
            child: TextFormField(
              keyboardType: widget.config.textInputType,
              controller: controller,
              maxLines: null,
              decoration: InputDecoration(
                hintText: widget.config.hint,
                hintStyle: widget.config.hintTextStyle,
                border: InputBorder.none,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                errorStyle: widget.config.errorTextStyle,
              ),
              textAlign: TextAlign.center,
              enableInteractiveSelection: !isReadOnly,
              readOnly: isReadOnly,
              style: widget.config.cellTextStyle,
              onChanged: (value) {
                widget.config.onChanged?.call(row, column, value);
              },
              validator: (value) {
                if (!isReadOnly) {
                  return widget.config.validator
                      ?.call(row, column, value ?? '');
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}
