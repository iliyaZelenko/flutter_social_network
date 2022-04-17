import 'dart:async';
import 'dart:io';

import 'package:app_http_client/app_http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showErrorMsg(Object error, GlobalKey<NavigatorState> mainNavigatorKey) {
  late final String msg;

  if (error is SocketException) {
    msg = 'Нет подключения к интернету';
  } else if (error is AppHttpException) {
    if (error.response != null) {
      String? defaultMsg = error.response?.data is String
          ? (error.response?.data as String).characters.take(200).toString() // .substring(0, min(200, str.length))
          : error.response?.data?['message']?.toString();

      if (defaultMsg == '') defaultMsg = null;

      if (error.response!.statusCode! >= 500 && error.response!.statusCode! < 600) {
        // Server error
        msg = defaultMsg ?? 'Ошибка сервера';
      } else if (error.response!.statusCode! >= 400 && error.response!.statusCode! < 500) {
        // Client error
        msg = defaultMsg ?? 'Ошибка клиента при запросе на сервер $error';
      } else {
        msg = defaultMsg ?? 'HTTP ошибка $error';
      }
    } else if (error.error != null) {
      msg = error.error.toString();
    }
  } else if (error is TimeoutException) {
    msg = 'Сервер не отвечает';
  } else if (error is Exception) {
    msg = '$error';
  } else {
    msg = 'Что-то пошло не так.\n$error';
  }

  if (mainNavigatorKey.currentContext != null) {
    showDialog<String>(
      context: mainNavigatorKey.currentContext!,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Ошибка'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => mainNavigatorKey.currentState?.pop(),
            child: const Text('Ок'),
          ),
        ],
      ),
    );
  }
}
