import 'dart:async';

import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String? _errorMessage; //! данная конструкция создана, для того, что бы никто
  String? get errorMessage =>
      _errorMessage; //! с наружи не мог поменять _errorMessage
  //! они будут получать всегда копию строки, а не сому строку и к самой переменной
  //! не будут иметь доступ, а значит не смогут её изменить
  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  //! смогу авторизоваться, если авторизация не в прогрессе сейчас
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    //! асинхронный метод void auth,
    final login = loginTextController.text;
    //! который требует BuildContext для навигации, что бы при авторизации могли
    final password = passwordTextController.text;
    //! куда то перейти, а асинхронный, так как запросы в сеть асинхронные

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await _apiClient.auth(
        username: login,
        password: password,
      );
    } catch (e) {
      _errorMessage = 'Неправильный логин пароль!';
    }
    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    if (sessionId == null) {
      _errorMessage = 'Неизвестная ошибка, поторите попытку';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    unawaited(Navigator.of(context).pushNamed('/main_screen'));
  }
}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;

  const AuthProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }
}
