import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

Uuid _uuid = new Uuid();

/// Generates a new v4 UUID using [UuidUtil.cryptoRNG].
String newUuid() {
  return _uuid.v4(options: {'rng': UuidUtil.cryptoRNG});
}
