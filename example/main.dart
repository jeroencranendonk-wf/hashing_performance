import 'dart:async';

import 'package:hashing_perf/hashing_perf.dart';

Future<Null> main() async {
  await runTests(10, 500);
  await runTests(10, 5000);
  await runTests(10, 50000);
  await runTests(100, 5000);
  await runTests(100, 50000);
}

Future runTests(int iterationWidth, int iterationCount) {
  print('starting $iterationCount x $iterationWidth');
  return testPerformance(iterationWidth, iterationCount).listen((pc) {
    if (pc.isTotal) print(pc);
  }).asFuture();
}
