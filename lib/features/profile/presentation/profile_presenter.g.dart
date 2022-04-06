// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfilePresenter on ProfilePresenterBase, Store {
  final _$profileAtom = Atom(name: 'ProfilePresenterBase.profile');

  @override
  ProfileEntity? get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(ProfileEntity? value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('ProfilePresenterBase.fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  @override
  String toString() {
    return '''
profile: ${profile}
    ''';
  }
}
