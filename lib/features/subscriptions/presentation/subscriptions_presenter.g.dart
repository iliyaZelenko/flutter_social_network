// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscriptions_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SubscriptionsPresenter on SubscriptionsPresenterBase, Store {
  final _$_loadingSubscribeInDialogAtom =
      Atom(name: 'SubscriptionsPresenterBase._loadingSubscribeInDialog');

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

  final _$subscribeAsyncAction =
      AsyncAction('SubscriptionsPresenterBase.subscribe');

  @override
  Future<bool?> subscribe(
      BuildContext context, Iterable<SubscriptionPlanEntity> plans) {
    return _$subscribeAsyncAction.run(() => super.subscribe(context, plans));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
