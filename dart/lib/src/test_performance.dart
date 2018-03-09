import 'dart:async';

import './iterate_hash_function.dart';

import './crypto.dart';
import './pointycastle.dart';

import './hash_function.dart';

final List<HashFunction> hashFunctions = [
  hashCryptoMd5,
  hashCryptoSha1,
  hashCryptoSha256,
  // hashPointyCastleMd5,
  // hashPointyCastleSha1,
  // hashPointyCastleSha256,
  // hashPointyCastleSha3,
  // hashPointyCastleWhirlpool,
];

Stream<PerformanceCounter> testPerformance(int iterationWidth, int iterationCount) {
  StreamController<PerformanceCounter> sc;

  sc = new StreamController<PerformanceCounter>(onListen: () {
    Future
        .forEach(hashFunctions, (fn) => sc.addStream(iterateHashFunction(fn, iterationWidth, iterationCount)))
        .then((_) => sc.close());
  });

  return sc.stream;
}
