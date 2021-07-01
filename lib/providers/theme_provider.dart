part of 'providers.dart';

class ThemeChangerProvider extends ChangeNotifier {
  bool _isLightTheme = true;
  bool get isLightTheme => _isLightTheme;

  void changeTheme() {
    _isLightTheme = !_isLightTheme;
    notifyListeners();
  }
}
