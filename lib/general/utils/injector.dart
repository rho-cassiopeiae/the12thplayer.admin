import 'package:kiwi/kiwi.dart';

import '../../account/bloc/account_bloc.dart';
import '../../account/interfaces/iaccount_api_service.dart';
import '../../account/services/account_api_service.dart';
import '../../account/services/account_service.dart';
import '../bloc/notification_bloc.dart';
import '../services/notification_service.dart';
import '../services/server_connector.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.singleton(ServerConnector)
  @Register.singleton(NotificationService)
  @Register.singleton(NotificationBloc)
  void configureGeneral();

  @Register.singleton(IAccountApiService, from: AccountApiService)
  @Register.singleton(AccountService)
  @Register.singleton(AccountBloc)
  void configureAccount();

  void configure() {
    configureGeneral();
    configureAccount();
  }
}

void setup() {
  var injector = _$Injector();
  injector.configure();
}
