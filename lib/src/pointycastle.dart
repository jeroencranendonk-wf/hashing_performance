import 'dart:convert';
import 'dart:typed_data';

import "package:pointycastle/pointycastle.dart";
import "package:pointycastle/export.dart";

import './hash_function.dart';

final HashFunction hashPointyCastleMd5 = _getHashFunction(new MD5Digest(), 'pointycastle MD5');
final HashFunction hashPointyCastleSha1 = _getHashFunction(new SHA1Digest(), 'pointycastle SHA1');
final HashFunction hashPointyCastleSha256 = _getHashFunction(new SHA256Digest(), 'pointycastle SHA256');
final HashFunction hashPointyCastleSha3 = _getHashFunction(new SHA3Digest(256), 'pointycastle SHA3-256');
final HashFunction hashPointyCastleWhirlpool = _getHashFunction(new WhirlpoolDigest(), 'pointycastle Whirlpool');

HashFunction _getHashFunction(Digest digest, String name) => new HashFunction(
    name: name,
    hash: (Iterable<String> values) =>
        BASE64.encode(digest.process(new Uint8List.fromList(values.expand(UTF8.encode)))));
