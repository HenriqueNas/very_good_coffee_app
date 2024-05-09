import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xff1B72C0),
  primary: const Color(0xff1B72C0),
  onPrimary: const Color(0xff001E2F),
  primaryContainer: const Color(0xffD3E4FF),
  onPrimaryContainer: const Color(0xff001C38),
  background: const Color(0xffFCFCFF),
  onBackground: const Color(0xff001E2F),
  surface: const Color.fromARGB(255, 202, 211, 230),
  onSurface: const Color(0xff001E2F),
  surfaceVariant: const Color(0xffEFF1F8),
  onSurfaceVariant: const Color(0xff74777F),
  inversePrimary: const Color(0xff001E2F),
);

final darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xff1B72C0),
  primary: const Color(0xff001C38),
  onPrimary: const Color(0xffD3E4FF),
  primaryContainer: const Color(0xff1B72C0),
  onPrimaryContainer: const Color(0xff001E2F),
  background: const Color(0xff001E2F),
  onBackground: const Color(0xffFCFCFF),
  surface: const Color.fromARGB(255, 6, 92, 142),
  onSurface: const Color(0xffFCFCFF),
  surfaceVariant: const Color(0xff001C38),
  onSurfaceVariant: const Color(0xffD3E4FF),
  inversePrimary: const Color(0xffD3E4FF),
);
