import 'package:meta/meta.dart';

typedef String Hasher(Iterable<String> values);

class HashFunction {
  final String name;
  final Hasher hash;
  HashFunction({@required this.name, @required this.hash});
}
