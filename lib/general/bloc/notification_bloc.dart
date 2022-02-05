import 'bloc.dart';
import 'notification_actions.dart';
import '../services/notification_service.dart';

class NotificationBloc extends Bloc<NotificationAction> {
  final NotificationService _notificationService;

  NotificationBloc(this._notificationService) {
    actionChannel.stream.listen(
      (action) {
        if (action is SetNavigatorKey) {
          _setNavigatorKey(action);
        }
      },
    );
  }

  @override
  void dispose({NotificationAction? cleanupAction}) {
    actionChannel.close();
  }

  void _setNavigatorKey(SetNavigatorKey action) {
    _notificationService.setNavigatorKey(action.navigatorKey);
  }
}
