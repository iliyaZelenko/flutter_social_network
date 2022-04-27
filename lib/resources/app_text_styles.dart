import 'dart:ui';

import 'package:flutter/material.dart';

const _fontFeatures = <FontFeature>[
  FontFeature.liningFigures(),
  FontFeature.proportionalFigures(),
];

mixin AppTextStyles {
  // Semi Bold
  static const semiBold32 = TextStyle(
    fontSize: 32,
    fontFamily: 'Raleway Semi Bold',
    fontFeatures: _fontFeatures,
  );

  // Regular
  static const regular18 = TextStyle(
    fontSize: 18,
    fontFamily: 'Raleway Regular',
    fontFeatures: _fontFeatures,
  );
  static const regular16 = TextStyle(
    fontSize: 16,
    fontFamily: 'Raleway Regular',
    fontFeatures: _fontFeatures,
  );
  static const regular15 = TextStyle(
    fontSize: 15,
    fontFamily: 'Raleway Regular',
    fontFeatures: _fontFeatures,
  );
  static const regular13 = TextStyle(
    fontSize: 13,
    fontFamily: 'Raleway Regular',
    fontFeatures: _fontFeatures,
  );

  // Medium
  static const medium15 = TextStyle(
    fontSize: 15,
    fontFamily: 'Raleway Medium',
    fontFeatures: _fontFeatures,
  );
  static const medium20 = TextStyle(
    fontSize: 20,
    fontFamily: 'Raleway Medium',
    fontFeatures: _fontFeatures,
  );
  static const medium13 = TextStyle(
    fontSize: 13,
    fontFamily: 'Raleway Medium',
    fontFeatures: _fontFeatures,
  );
}

mixin AppTextStylesOld {
  // Semi Bold
  static const semiBold25 = TextStyle(
    fontSize: 25,
    fontFamily: 'Inter Semi Bold',
    fontFeatures: _fontFeatures,
  );
  static const semiBold20 = TextStyle(
    fontSize: 20,
    fontFamily: 'Inter Semi Bold',
    fontFeatures: _fontFeatures,
  );
  static const semiBold16 = TextStyle(
    fontSize: 16,
    fontFamily: 'Inter Semi Bold',
    fontFeatures: _fontFeatures,
  );
  static const semiBold15 = TextStyle(
    fontSize: 15,
    fontFamily: 'Inter Semi Bold',
    fontFeatures: _fontFeatures,
  );

  // Medium
  static const medium16 = TextStyle(
    fontSize: 16,
    fontFamily: 'Raleway Medium',
    fontFeatures: _fontFeatures,
  );
  static const medium15 = TextStyle(
    fontSize: 15,
    fontFamily: 'Raleway Medium',
    fontFeatures: _fontFeatures,
  );
  static const medium14 = TextStyle(
    fontSize: 14,
    fontFamily: 'Raleway Medium',
    fontFeatures: _fontFeatures,
  );
  static const medium12 = TextStyle(
    fontSize: 12,
    fontFamily: 'Raleway Medium',
    fontFeatures: _fontFeatures,
  );

  // Regular
  static const regular15 = TextStyle(
    fontSize: 15,
    fontFamily: 'Raleway Regular',
    fontFeatures: _fontFeatures,
  );
  static const regular12 = TextStyle(
    fontSize: 12,
    fontFamily: 'Raleway Regular',
    fontFeatures: _fontFeatures,
  );
  static const regular9 = TextStyle(
    fontSize: 9,
    fontFamily: 'Raleway Regular',
    fontFeatures: _fontFeatures,
  );
}
