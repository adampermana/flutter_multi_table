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

    // Inisialisasi _config setelah konteks telah tersedia
    _config = FlutterMultiTableConfig(
      headers: headers,
      hint: '....',
      validator: (row, column, value) {
        if (column == 2 && (value.isEmpty)) {
          return 'Data wajib diisi'; // Kolom 3 ('Hasil') harus diisi
        }

        // Validasi default untuk kolom lain jika diperlukan
        return null; // Tidak ada pesan error jika validasi lolos
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
        if (column == 0 || column == 1 || column == 3 || column == 4) {
          return true;
        }
        return false;
      },
      isDropdown: (row, column) {
        // Define conditions when the dropdown should be used

        // Range Column 0-5
        // for portraits maximum 5 tables
        // Define conditions when the dropdown should be used
        if (column == 2 && (row != 1 && row != 13)) {
          return true;
        }
        return false;
      },
      dropdownOptions: ['New York', 'London', 'Tokyo', 'Paris'],
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
