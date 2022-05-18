// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_profile_screen_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OtherProfileScreenPresenter on OtherProfileScreenPresenterBase, Store {
  Computed<ProfileScreenEntity?>? _$profileComputed;

  @override
  ProfileScreenEntity? get profile =>
      (_$profileComputed ??= Computed<ProfileScreenEntity?>(() => super.profile,
              name: 'OtherProfileScreenPresenterBase.profile'))
          .value;
  Computed<List<PostEntity>?>? _$postsComputed;

  @override
  List<PostEntity>? get posts =>
      (_$postsComputed ??= Computed<List<PostEntity>?>(() => super.posts,
              name: 'OtherProfileScreenPresenterBase.posts'))
          .value;
  Computed<int?>? _$postsCountComputed;

  @override
  int? get postsCount =>
      (_$postsCountComputed ??= Computed<int?>(() => super.postsCount,
              name: 'OtherProfileScreenPresenterBase.postsCount'))
          .value;

  final _$_fetchedProfileAtom =
      Atom(name: 'OtherProfileScreenPresenterBase._fetchedProfile');

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

  final _$_feedResponseAtom =
      Atom(name: 'OtherProfileScreenPresenterBase._feedResponse');

  FeedResponse? get feedResponse {
    _$_feedResponseAtom.reportRead();
    return super._feedResponse;
  }

  @override
  FeedResponse? get _feedResponse => feedResponse;

  @override
  set _feedResponse(FeedResponse? value) {
    _$_feedResponseAtom.reportWrite(value, super._feedResponse, () {
      super._feedResponse = value;
    });
  }

  final _$_loadingAtom = Atom(name: 'OtherProfileScreenPresenterBase._loading');

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

  final _$currentTabAtom =
      Atom(name: 'OtherProfileScreenPresenterBase.currentTab');

  @override
  int get currentTab {
    _$currentTabAtom.reportRead();
    return super.currentTab;
  }

  @override
  set currentTab(int value) {
    _$currentTabAtom.reportWrite(value, super.currentTab, () {
      super.currentTab = value;
    });
  }

  final _$_loadingSubscribeAtom =
      Atom(name: 'OtherProfileScreenPresenterBase._loadingSubscribe');

  bool get loadingSubscribe {
    _$_loadingSubscribeAtom.reportRead();
    return super._loadingSubscribe;
  }

  @override
  bool get _loadingSubscribe => loadingSubscribe;

  @override
  set _loadingSubscribe(bool value) {
    _$_loadingSubscribeAtom.reportWrite(value, super._loadingSubscribe, () {
      super._loadingSubscribe = value;
    });
  }

  final _$_loadingSubscribeInDialogAtom =
      Atom(name: 'OtherProfileScreenPresenterBase._loadingSubscribeInDialog');

  bool get loadingSubscribeInDialog {
    _$_loadingSubscribeInDialogAtom.reportRead();
    return super._loadingSubscribeInDialog;
  }

  @override
  bool get _loadingSubscribeInDialog => loadingSubscribeInDialog;

  @override
  set _loadingSubscribeInDialog(bool value) {
    _$_loadingSubscribeInDialogAtom
        .reportWrite(value, super._loadingSubscribeInDialog, () {
      super._loadingSubscribeInDialog = value;
    });
  }

  final _$fetchAsyncAction =
      AsyncAction('OtherProfileScreenPresenterBase.fetch');

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$fetchFeedAsyncAction =
      AsyncAction('OtherProfileScreenPresenterBase.fetchFeed');

  @override
  Future<void> fetchFeed() {
    return _$fetchFeedAsyncAction.run(() => super.fetchFeed());
  }

  final _$refreshAsyncAction =
      AsyncAction('OtherProfileScreenPresenterBase.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$subscribeAsyncAction =
      AsyncAction('OtherProfileScreenPresenterBase.subscribe');

  @override
  Future<void> subscribe(BuildContext context) {
    return _$subscribeAsyncAction.run(() => super.subscribe(context));
  }

  final _$openMenuAsyncAction =
      AsyncAction('OtherProfileScreenPresenterBase.openMenu');

  @override
  Future<void> openMenu(BuildContext context) {
    return _$openMenuAsyncAction.run(() => super.openMenu(context));
  }

  @override
  String toString() {
    return '''
currentTab: ${currentTab},
profile: ${profile},
posts: ${posts},
postsCount: ${postsCount}
    ''';
  }
}
