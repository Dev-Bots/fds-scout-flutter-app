// ignore: prefer_const_declarations
import 'package:dev_scout_fds/Data/provider/interceptors/interceptors.dart';
import 'package:http_interceptor/http/http.dart';

final baseURL = '10.0.2.2:8000';

final httpClient = InterceptedHttp.build(interceptors: [
  Interceptors(),
], retryPolicy: ExpiredTokenRetryPolicy());
