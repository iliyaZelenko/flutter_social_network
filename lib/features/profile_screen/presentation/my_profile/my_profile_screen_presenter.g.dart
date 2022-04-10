// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_screen_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyProfileScreenPresenter on MyProfileScreenPresenterBase, Store {
  Computed<ProfileScreenEntity?>? _$profileComputed;

  @override
  ProfileScreenEntity? get profile =>
      (_$profileComputed ??= Computed<ProfileScreenEntity?>(() => super.profile,
              name: 'MyProfileScreenPresenterBase.profile'))
          .value;

  final _$_fetchedProfileAtom =
      Atom(name: 'MyProfileScreenPresenterBase._fetchedProfile');

  ProfileScreenEntity? get fetchedProfile {
    _$_fetchedProfileAtom.reportRead();
    return super._fetchedProfile;
  }

  @override
  ProfileScreenEntity? get _fetchedProfile => fetchedProfile;

  @override
  set _fetchedProfile(ProfileScreenEntity? value) {
    _$_fetchedProfileAtom.reportWrite(value, super._fetchedProfile, () {
      super._fetchedProfile = value;
    });
  }

  final _$_loadingAtom = Atom(name: 'MyProfileScreenPresenterBase._loading');

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

  final _$fetchAsyncAction = AsyncAction('MyProfileScreenPresenterBase.fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$refreshAsyncAction =
      AsyncAction('MyProfileScreenPresenterBase.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  @override
  String toString() {
    return '''
profile: ${profile}
    ''';
  }
}
