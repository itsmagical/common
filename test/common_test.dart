import 'package:common/util/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common/common.dart';

void main() {
  debugPrint('run test1');
  test('adds one to input values', () async {
    await Common.init();
  });
}
