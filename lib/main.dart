import 'package:fluent_ui/fluent_ui.dart';

import 'general/bloc/notification_actions.dart';
import 'general/bloc/notification_bloc.dart';
import 'general/extensions/kiwi_extension.dart';
import 'general/utils/injector.dart';
import 'account/pages/auth_page.dart';

void main() {
  setup();
  runApp(Application());
}

class Application extends StatelessWidgetWith<NotificationBloc> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget buildWith(BuildContext context, NotificationBloc notificationBloc) {
    notificationBloc.dispatchAction(
      SetNavigatorKey(navigatorKey: _navigatorKey),
    );

    return FluentApp(
      navigatorKey: _navigatorKey,
      title: 'The 12th Player',
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
