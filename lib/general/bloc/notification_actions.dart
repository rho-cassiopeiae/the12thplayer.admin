import 'package:fluent_ui/fluent_ui.dart';

abstract class NotificationAction {}

class SetNavigatorKey extends NotificationAction {
  final GlobalKey<NavigatorState> navigatorKey;

  SetNavigatorKey({required this.navigatorKey});
}
