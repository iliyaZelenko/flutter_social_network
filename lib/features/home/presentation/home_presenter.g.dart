// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePresenter on HomePresenterBase, Store {
  final _$tapBarNavigationIndexAtom =
      Atom(name: 'HomePresenterBase.tapBarNavigationIndex');

  @override
  int get tapBarNavigationIndex {
    _$tapBarNavigationIndexAtom.reportRead();
    return super.tapBarNavigationIndex;
  }

  @override
  set tapBarNavigationIndex(int value) {
    _$tapBarNavigationIndexAtom.reportWrite(value, super.tapBarNavigationIndex,
        () {
      super.tapBarNavigationIndex = value;
    });
  }

  @override
  String toString() {
    return '''
tapBarNavigationIndex: ${tapBarNavigationIndex}
    ''';
  }
}
