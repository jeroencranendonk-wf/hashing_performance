import 'dart:async';
import 'dart:html' show querySelector;

import 'package:hashing_perf/hashing_perf.dart';

final List<HashFunction> hashFunctions = [
  hashCryptoMd5,
  hashCryptoSha1,
  hashCryptoSha256,
  murmur,
];

Future<Null> main() async {
  for (HashFunction fn in hashFunctions) {
    await runTests(fn, 10, 500);
    await runTests(fn, 10, 5000);
    await runTests(fn, 10, 50000);
    await runTests(fn, 100, 5000);
    await runTests(fn, 100, 50000);
  }
}

Future runTests(HashFunction fn, int iterationWidth, int iterationCount) async {
  await new Future.delayed(const Duration(milliseconds: 100));
  return iterateHashFunction(fn, iterationWidth, iterationCount).listen((t) {
    querySelector('body').appendHtml('<div>${fn.name} ${iterationCount}x${iterationWidth}: ${t.inMilliseconds}ms</div>');
  }).asFuture();
}
