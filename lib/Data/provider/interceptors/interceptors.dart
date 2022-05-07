import 'dart:convert';

import 'package:dev_scout_fds/Bloc/AuthBloc/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dev_scout_fds/Data/provider/config/config.dart';
import 'package:dev_scout_fds/Data/provider/provider.dart';
import 'package:http/retry.dart';

class Interceptors implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      data.headers["Content-Type"] = "application/json";
      data.headers["Accept"] = "application/json";
      data.headers["Authorization"] =
          "Bearer ${prefs.getString('accessToken')}";
      print(data);
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // final prefs = await SharedPreferences.getInstance();

    // try {
    //   if (data.statusCode == 401) {
    //     await AuthDataProvider().RefreshToken();

    //     data.headers!["Authorization"] =
    //         "Bearer ${prefs.getString('accessToken')}";

    //     return data;
    //   }
    // } catch (e) {
    //   print(e);
    // }
    return data;
  }
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  AuthBloc authBloc = AuthBloc();
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    final prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 401) {
      await AuthDataProvider().RefreshToken();

      // authBloc.add(RefreshToken(
      //     refreshToken: prefs.getString('refreshToken').toString()));
      return true;
    }

    return false;
  }
}

// class Interceptors {
//   final _baseUrl = baseURL;

//   // final http.Client httpClient;

//   String? accessToken;

//   Interceptors() {
//     dio.interceptors
//         .add(InterceptorsWrapper(onRequest: (options, handler) async {
//       if (!options.path.contains('http')) {
//         print(
//             'Interceptorooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
//         options.path = _baseUrl + options.path;
//       }

//       options.headers['Authorization'] = 'Bearer $accessToken';
//       return handler.next(options);
//     }, onError: (DioError error, handler) async {
//       // print('ERROR[${error.response.statusCode}] => PATH: ${error.request.path}');
//       if ((error.response?.statusCode == 401)) {
//         print(
//             'Invalid JWT00000000000000000000000000000000000000000000000000000000000000');
//         await refreshToken();
//         return handler.resolve(await _retry(error.requestOptions));
//       }
//       return handler.next(error);
//     }));
//   }

//   Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
//     final options = Options(
//       method: requestOptions.method,
//       headers: requestOptions.headers,
//     );
//     return await dio.request(requestOptions.path, options: options);
//   }

//   Future refreshToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     try {
//       final response = await dio.post('10.0.2.2:8000/api/token/refresh/',
//           data: {'refresh': prefs.getString('refreshToken')});

//       if (response.statusCode == 201) {
//         final accessToken = jsonDecode(response.data)['access'];
//         prefs.setString('accessToken', accessToken);
//         return response.data;
//       }
//     } catch (e) {
//       print('AUTH ERROR $e');
//     }
//   }
// }
