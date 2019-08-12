import 'dart:typed_data';

class TargetServer {
  TargetServer._internal();
  static final TargetServer _instance = new TargetServer._internal();

  factory TargetServer() {
    return _instance;
  }

  String root() {
    bool inDebugMode = false;
    assert(inDebugMode = true);

    if (inDebugMode == true) {
      return "dev";
    }

    return "real";
  }
}
