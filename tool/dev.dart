library tool.dev;

import 'dart:async';

import 'package:dart_dev/dart_dev.dart' show dev, config;

Future<dynamic> main(List<String> args) async {
  // https://github.com/Workiva/dart_dev

  config.analyze
    ..entryPoints = [
      'lib/hashing_perf.dart',
    ]
    ..strong = true;

  config.format
    ..paths = [
      'example/',
      'lib/',
      // 'test/',
    ]
    ..exclude = ['tool/over_react_format/']
    ..lineLength = 120;

  config.test
    ..platforms = [
      'dartium',
    ]
    ..unitTests = [
      'test/unit/suite_test.dart',
    ];

  await dev(args);
}
