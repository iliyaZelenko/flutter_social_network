// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthPresenter on AuthPresenterBase, Store {
  Computed<bool>? _$loggedInComputed;

  @override
  bool get loggedIn =>
      (_$loggedInComputed ??= Computed<bool>(() => super.loggedIn,
              name: 'AuthPresenterBase.loggedIn'))
          .value;

  final _$signInAsyncAction = AsyncAction('AuthPresenterBase.signIn');

  @override
  Future<void> signIn({required String username, required String password}) {
    return _$signInAsyncAction
        .run(() => super.signIn(username: username, password: password));
  }

  final _$fetchCurrentUserAsyncAction =
      AsyncAction('AuthPresenterBase.fetchCurrentUser');

  @override
  Future<void> fetchCurrentUser() {
    return _$fetchCurrentUserAsyncAction.run(() => super.fetchCurrentUser());
  }

  @override
  String toString() {
    return '''
loggedIn: ${loggedIn}
    ''';
  }
}
