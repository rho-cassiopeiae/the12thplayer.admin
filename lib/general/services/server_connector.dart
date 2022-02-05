import 'package:dio/dio.dart';

class ServerConnector {
  late final Dio _dioIdentity;
  late final Dio _dioAdmin;

  late String _accessToken;

  Dio get dioIdentity => _dioIdentity;
  Dio get dioAdmin => _dioAdmin;

  String get accessToken => _accessToken;

  ServerConnector() {
    _dioIdentity = Dio(
      BaseOptions(baseUrl: 'http://192.168.0.3:5000'),
    );
    _dioAdmin = Dio(
      BaseOptions(baseUrl: 'http://192.168.0.3:7000'),
    );
  }

  void setToken(String accessToken) {
    _accessToken = accessToken;
  }
}
