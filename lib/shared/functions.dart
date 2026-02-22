import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void unfocus() => FocusManager.instance.primaryFocus?.unfocus();

void scheduleAfterBuild(VoidCallback function) =>
    SchedulerBinding.instance.addPostFrameCallback((_) => function.call());

extension StringExtensions on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
