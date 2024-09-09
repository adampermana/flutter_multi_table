import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_multi_table_method_channel.dart';

abstract class FlutterMultiTablePlatform extends PlatformInterface {
  /// Constructs a FlutterMultiTablePlatform.
  FlutterMultiTablePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterMultiTablePlatform _instance = MethodChannelFlutterMultiTable();

  /// The default instance of [FlutterMultiTablePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterMultiTable].
  static FlutterMultiTablePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterMultiTablePlatform] when
  /// they register themselves.
  static set instance(FlutterMultiTablePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
