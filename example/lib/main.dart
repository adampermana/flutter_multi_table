// File: example/lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_multi_table/flutter_multi_table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Multi Table Example')),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FlutterMultiTableController _controller;
  late FlutterMultiTableConfig _config;

  @override
  void initState() {
    super.initState();
    List<String> headers = [
      'No',
      'Name',
      'Age',
      'City',
      'Status',
    ];
    List<Map<String, String>> initialData = [
      {
        'No': '1',
        'Name': 'John',
        'Age': '',
        'City': 'New York',
        'Status': 'Active',
      },
      {
        'No': '2',
        'Name': 'Alice',
        'Age': '',
        'City': 'London',
        'Status': 'Inactive',
      },
    ];

    _controller = FlutterMultiTableController(
      initialData: initialData,
      headers: headers,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    List<String> headers = [
      'No',
      'Name',
      'Age',
      'City',
      'Status',
    ];

    // Initialize _config once the context is available
    _config = FlutterMultiTableConfig(
      headers: headers,
      hint: '....',
      validator: (row, column, value) {
        // Default validation for other columns if needed
        if (column == 2 && (value.isEmpty)) {
          return 'Data wajib diisi'; // Column 3 ('Results') is required
        }
        return null;
      },
      dropdownValidator: (row, column, value) {
        if (column == 2 && (value == null || value.isEmpty)) {
          return 'Data wajib diisi'; // Wajib
        }
        // Add more validation logic as needed
        return null; // Return null if the value is valid
      },
      headerTextStyle: const TextStyle(
        fontSize: 10,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      errorTextStyle: const TextStyle(fontSize: 8, color: Colors.red),
      cellTextStyle: const TextStyle(
        fontSize: 6,
        fontWeight: FontWeight.w600,
      ),
      cellWidth: MediaQuery.of(context).size.width * 0.182,
      cellHeight: MediaQuery.of(context).size.height * 0.04,
      hintTextStyle: const TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.w400,
      ),
      isReadOnly: (row, column) {
        // Callback to determine if a cell is read-only.
        // Column and Row range starts from 0-5.
        if (column == 0 || column == 1 || column == 3 || column == 4) {
          return true;
        }
        return false;
      },
      isDropdown: (row, column) {
        // Define conditions when the dropdown should be used
        // Column and Row range starts from 0-100
        if (column == 2 && (row != 1 && row != 13)) {
          return true;
        }
        return false;
      },
      dropdownOptions: ['Jakarta', 'New York', 'London', 'Tokyo', 'Paris'],
      onChanged: (row, column, value) {
        debugPrint('Changed: Row $row, Column $column, Value: $value');
        // List<Map<String, String>> updatedTableData = List.from(state.tableData);

        // while (row >= updatedTableData.length) {
        //   updatedTableData.add({for (var header in state.headers) header: ''});
        // }

        // updatedTableData[row][state.headers[column]] = value;
        // context
        //     .read<VehicleReportBloc>()
        //     .add(VehicleReportEvent.tableChanged(updatedTableData));
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          FlutterMultiTable(
            controller: _controller,
            config: _config,
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Text('Submit'))
        ],
      ),
    );
  }
}
