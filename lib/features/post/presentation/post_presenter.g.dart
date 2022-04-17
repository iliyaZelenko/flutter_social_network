// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostPresenter on PostPresenterBase, Store {
  final _$_loadingAtom = Atom(name: 'PostPresenterBase._loading');

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

  final _$_postAtom = Atom(name: 'PostPresenterBase._post');

  PostEntity? get post {
    _$_postAtom.reportRead();
    return super._post;
  }

  @override
  PostEntity? get _post => post;

  @override
  set _post(PostEntity? value) {
    _$_postAtom.reportWrite(value, super._post, () {
      super._post = value;
    });
  }

  final _$initFetchAsyncAction = AsyncAction('PostPresenterBase.initFetch');

  @override
  Future<void> initFetch(PostId id) {
    return _$initFetchAsyncAction.run(() => super.initFetch(id));
  }

  final _$refreshAsyncAction = AsyncAction('PostPresenterBase.refresh');

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
