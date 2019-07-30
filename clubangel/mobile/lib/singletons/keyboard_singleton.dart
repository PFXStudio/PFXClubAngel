import 'package:keyboard_visibility/keyboard_visibility.dart';

class KeyboardSingleton {
  KeyboardSingleton._internal();
  static final KeyboardSingleton _instance = new KeyboardSingleton._internal();
  bool _isKeyboardVisible = false;

  factory KeyboardSingleton() {
    return _instance;
  }

  bool isKeyboardVisible() {
    return _isKeyboardVisible;
  }

  void initialize() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool isVisible) {
        _isKeyboardVisible = isVisible;
      },
    );
  }
}
