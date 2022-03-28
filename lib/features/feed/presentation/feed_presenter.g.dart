// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedPresenter on FeedPresenterBase, Store {
  final _$_loadingAtom = Atom(name: 'FeedPresenterBase._loading');

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

  final _$_feedAtom = Atom(name: 'FeedPresenterBase._feed');

  FeedResponseEntity? get feed {
    _$_feedAtom.reportRead();
    return super._feed;
  }

  @override
  FeedResponseEntity? get _feed => feed;

  @override
  set _feed(FeedResponseEntity? value) {
    _$_feedAtom.reportWrite(value, super._feed, () {
      super._feed = value;
    });
  }

  final _$profileAtom = Atom(name: 'FeedPresenterBase.profile');

  @override
  Profile? get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(Profile? value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  final _$initFetchAsyncAction = AsyncAction('FeedPresenterBase.initFetch');

  @override
  Future<void> initFetch() {
    return _$initFetchAsyncAction.run(() => super.initFetch());
  }

  final _$FeedPresenterBaseActionController =
      ActionController(name: 'FeedPresenterBase');

  @override
  Future<void> refresh() {
    final _$actionInfo = _$FeedPresenterBaseActionController.startAction(
        name: 'FeedPresenterBase.refresh');
    try {
      return super.refresh();
    } finally {
      _$FeedPresenterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
profile: ${profile}
    ''';
  }
}
