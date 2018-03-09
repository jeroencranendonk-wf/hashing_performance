import 'dart:convert';

import 'package:crypto/crypto.dart';

import './hash_function.dart';

final HashFunction hashCryptoMd5 = _getHashFunction(md5, 'crypto MD5');
final HashFunction hashCryptoSha1 = _getHashFunction(sha1, 'crypto SHA1');
final HashFunction hashCryptoSha256 = _getHashFunction(sha256, 'crypto SHA256');

HashFunction _getHashFunction(Hash hash, String name) => new HashFunction(
    name: name, hash: (Iterable<String> values) => BASE64.encode(hash.convert(values.expand(UTF8.encode)).bytes));
