import 'package:flutter/material.dart';

// TODO Ilya: replace all to hex format
mixin AppColors {
  static const transparent = Color(0x00000000);

  static const black100 = Color(0xFF000000);
  static const black80 = Color(0xFF343341);
  static const black60 = Color(0xFF5B5A69);
  static const black40 = Color.fromRGBO(0x76, 0x75, 0x87, 1);
  static const black20 = Color.fromRGBO(0x96, 0x96, 0xA4, 1);

  static const white100 = Color.fromRGBO(0xff, 0xff, 0xff, 1);
  static const white80 = Color.fromRGBO(0xfa, 0xfa, 0xfd, 1);
  static const white60 = Color.fromRGBO(0xe8, 0xeb, 0xf4, 1);
  static const white40 = Color.fromRGBO(0xd3, 0xfd8, 0xe2, 1);
  static const white20 = Color.fromRGBO(0xc9, 0xfcb, 0xdf, 1);

  static const blue100 = Color(0xFF3051C7);
  static const blue80 = Color(0xFF385FEA);
  static const blue60 = Color(0xFFCED7FA);

  static const purple100 = Color(0xFF5F1857);
  static const purple80 = Color(0xFFDCC9DA);
  static const purple20 = Color(0xFFFFF6FE);

  static const red100 = Color.fromRGBO(0xb6, 0x14, 0x14, 1);
  static const red80 = Color(0xFFeb5b52);

  static const shadow = Color.fromRGBO(0x5B, 0x5A, 0x69, 0.2);
}
