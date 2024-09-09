// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_multi_table/flutter_multi_table.dart';
// import 'package:flutter_multi_table/flutter_multi_table_platform_interface.dart';
// import 'package:flutter_multi_table/flutter_multi_table_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockFlutterMultiTablePlatform
//     with MockPlatformInterfaceMixin
//     implements FlutterMultiTablePlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final FlutterMultiTablePlatform initialPlatform = FlutterMultiTablePlatform.instance;

//   test('$MethodChannelFlutterMultiTable is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelFlutterMultiTable>());
//   });

//   test('getPlatformVersion', () async {
//     FlutterMultiTable flutterMultiTablePlugin = FlutterMultiTable();
//     MockFlutterMultiTablePlatform fakePlatform = MockFlutterMultiTablePlatform();
//     FlutterMultiTablePlatform.instance = fakePlatform;

//     expect(await flutterMultiTablePlugin.getPlatformVersion(), '42');
//   });
// }
