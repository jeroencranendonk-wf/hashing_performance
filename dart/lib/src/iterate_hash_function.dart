import 'dart:async';

import './hash_function.dart';
import './uuid.dart';

Stream<Duration> iterateHashFunction(HashFunction fn, int width, int iterations) {
  StreamController<Duration> sc;

  Future<Null> measure() async {
    List<String> values = new List.filled(width, newUuid(), growable: false);

    Stopwatch total = new Stopwatch()..start();

    for (int i = 0; i < iterations; i++) {
      fn.hash(values);
    }

    sc.add(total.elapsed);
    sc.close();
  }

  sc = new StreamController<Duration>(onListen: measure);
  return sc.stream;
}
