// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://docs.flutter.dev/cookbook/testing/integration/introduction

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_multi_table/flutter_multi_table.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Dropdown selection updates value', (WidgetTester tester) async {
    final controller = FlutterMultiTableController(
      initialData: [
        {'Name': 'John', 'Age': '25'}
      ],
      headers: ['Name', 'Age'],
    );
    final config = FlutterMultiTableConfig(
      headers: ['Name', 'Age'],
      isDropdown: (row, col) => col == 1,
      dropdownOptions: ['25', '30', '35'],
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlutterMultiTable(controller: controller, config: config),
      ),
    ));

    // Memilih nilai dari dropdown
    await tester.tap(find.byType(DropdownButtonFormField<String>).first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('30').last);
    await tester.pumpAndSettle();

    expect(controller.getCellValue(0, 1), '30');
  });

  testWidgets('Table cell updates on input', (WidgetTester tester) async {
    final controller = FlutterMultiTableController(
      initialData: [
        {'Name': 'John', 'Age': '25'}
      ],
      headers: ['Name', 'Age'],
    );
    final config = FlutterMultiTableConfig(headers: ['Name', 'Age']);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlutterMultiTable(controller: controller, config: config),
      ),
    ));

    // Mengisi teks baru ke dalam sel tabel
    await tester.enterText(find.byType(TextFormField).first, 'Doe');
    expect(controller.getCellValue(0, 0), 'Doe');
  });
}
