// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void configureGeneral() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => ServerConnector())
      ..registerSingleton((c) => NotificationService())
      ..registerSingleton((c) => NotificationBloc(c<NotificationService>()));
  }

  @override
  void configureAccount() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton<IAccountApiService>(
          (c) => AccountApiService(c<ServerConnector>()))
      ..registerSingleton((c) => AccountService(c<ServerConnector>(),
          c<IAccountApiService>(), c<NotificationService>()))
      ..registerSingleton((c) => AccountBloc(c<AccountService>()));
  }
}
