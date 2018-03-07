import 'dart:async';

import 'package:meta/meta.dart';

import './hash_function.dart';
import './uuid.dart';

String _uuid(_) => newUuid();

class PerformanceCounter {
  final String name;
  final Duration duration;
  final bool isTotal;
  PerformanceCounter({@required this.name, @required this.duration, @required this.isTotal});

  @override
  String toString() => 'PerformanceCounter($name, $duration, $isTotal)';
}

Stream<PerformanceCounter> iterateHashFunction(HashFunction fn, int width, int iterations) {
  StreamController<PerformanceCounter> sc;

  Future<Null> measure() async {
    List<String> values = new List.generate(iterations + width - 1, _uuid, growable: false);

    Stopwatch total = new Stopwatch()..start();
    // Stopwatch iter = new Stopwatch()..start();

    for (int i = 0; i < iterations; i++) {
      fn.hash(values.sublist(i, i + width));

      // sc.add(new PerformanceCounter(name: fn.name, duration: iter.elapsed, isTotal: false));
      // iter.reset();
    }

    sc.add(new PerformanceCounter(name: fn.name, duration: total.elapsed, isTotal: true));
    sc.close();
  }

  sc = new StreamController<PerformanceCounter>(onListen: measure);
  return sc.stream;
}
