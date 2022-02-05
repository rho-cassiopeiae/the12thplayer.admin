import 'package:fluent_ui/fluent_ui.dart';

class NotificationService {
  late final GlobalKey<NavigatorState> _navigatorKey;

  void setNavigatorKey(GlobalKey<NavigatorState> navigatorKey) =>
      _navigatorKey = navigatorKey;

  void showMessage(String message, {String? title}) {
    showDialog(
      context: _navigatorKey.currentContext!,
      builder: (context) => ContentDialog(
        title: title != null ? Text(title) : null,
        content: Text(message),
        actions: [
          Button(
            child: Text('Close'),
            onPressed: () {
              _navigatorKey.currentState!.pop();
            },
          )
        ],
      ),
    );
  }
}
