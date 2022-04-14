// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_flow_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthFlowPresenter on AuthFlowPresenterBase, Store {
  final _$_loadingAtom = Atom(name: 'AuthFlowPresenterBase._loading');

  bool get loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  bool get _loading => loading;

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  final _$_usernameAtom = Atom(name: 'AuthFlowPresenterBase._username');

  String get username {
    _$_usernameAtom.reportRead();
    return super._username;
  }

  @override
  String get _username => username;

  @override
  set _username(String value) {
    _$_usernameAtom.reportWrite(value, super._username, () {
      super._username = value;
    });
  }

  final _$_passwordAtom = Atom(name: 'AuthFlowPresenterBase._password');

  String get password {
    _$_passwordAtom.reportRead();
    return super._password;
  }

  @override
  String get _password => password;

  @override
  set _password(String value) {
    _$_passwordAtom.reportWrite(value, super._password, () {
      super._password = value;
    });
  }

  final _$_errorAtom = Atom(name: 'AuthFlowPresenterBase._error');

  String? get error {
    _$_errorAtom.reportRead();
    return super._error;
  }

  @override
  String? get _error => error;

  @override
  set _error(String? value) {
    _$_errorAtom.reportWrite(value, super._error, () {
      super._error = value;
    });
  }

  final _$hidePasswordAtom = Atom(name: 'AuthFlowPresenterBase.hidePassword');

  @override
  bool get hidePassword {
    _$hidePasswordAtom.reportRead();
    return super.hidePassword;
  }

  @override
  set hidePassword(bool value) {
    _$hidePasswordAtom.reportWrite(value, super.hidePassword, () {
      super.hidePassword = value;
    });
  }

  final _$rememberMeAtom = Atom(name: 'AuthFlowPresenterBase.rememberMe');

  @override
  bool get rememberMe {
    _$rememberMeAtom.reportRead();
    return super.rememberMe;
  }

  @override
  set rememberMe(bool value) {
    _$rememberMeAtom.reportWrite(value, super.rememberMe, () {
      super.rememberMe = value;
    });
  }

  final _$signInAsyncAction = AsyncAction('AuthFlowPresenterBase.signIn');

  @override
  Future<void> signIn() {
    return _$signInAsyncAction.run(() => super.signIn());
  }

  final _$AuthFlowPresenterBaseActionController =
      ActionController(name: 'AuthFlowPresenterBase');

  @override
  void setInput({String? username, String? password}) {
    final _$actionInfo = _$AuthFlowPresenterBaseActionController.startAction(
        name: 'AuthFlowPresenterBase.setInput');
    try {
      return super.setInput(username: username, password: password);
    } finally {
      _$AuthFlowPresenterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hidePassword: ${hidePassword},
rememberMe: ${rememberMe}
    ''';
  }
}
