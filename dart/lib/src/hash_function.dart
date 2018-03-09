import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:meta/meta.dart';
import './murmur.dart';

typedef dynamic Hasher(Iterable<String> values);

class HashFunction {
  final String name;
  final Hasher hash;
  HashFunction({@required this.name, @required this.hash});
}

final HashFunction hashCryptoMd5 = new HashFunction(name: 'md5', hash: _getHashFunction(md5));
final HashFunction hashCryptoSha1 = new HashFunction(name: 'sha1', hash: _getHashFunction(sha1));
final HashFunction hashCryptoSha256 = new HashFunction(name: 'sha256', hash: _getHashFunction(sha256));
final HashFunction murmur = new HashFunction(
    name: 'murmur',
    hash: (values) {
      MurmurHash3 m = new MurmurHash3();
      values.forEach(m.hash);
      return m.result();
    });

Hasher _getHashFunction(Hash hash) => (Iterable<String> values) => hash.convert(values.expand(UTF8.encode)).bytes;
