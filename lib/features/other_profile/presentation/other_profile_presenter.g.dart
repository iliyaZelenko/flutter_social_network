// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_profile_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OtherProfilePresenter on OtherProfilePresenterBase, Store {
  final _$_profileAtom = Atom(name: 'OtherProfilePresenterBase._profile');

  OtherProfileEntity? get profile {
    _$_profileAtom.reportRead();
    return super._profile;
  }

  @override
  OtherProfileEntity? get _profile => profile;

  @override
  set _profile(OtherProfileEntity? value) {
    _$_profileAtom.reportWrite(value, super._profile, () {
      super._profile = value;
    });
  }

  final _$_loadingAtom = Atom(name: 'OtherProfilePresenterBase._loading');

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

  final _$fetchAsyncAction = AsyncAction('OtherProfilePresenterBase.fetch');

  @override
  Future<void> fetch(String username) {
    return _$fetchAsyncAction.run(() => super.fetch(username));
  }

  final _$refreshAsyncAction = AsyncAction('OtherProfilePresenterBase.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
