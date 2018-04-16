class MurmurHash3 {
  int _len;
  int _k1;
  int _rem;
  int _h1;

  MurmurHash3({String key, int seed}) {
    reset(seed: seed);
    if (key != null && key.isNotEmpty) {
      hash(key);
    }
  }

  void hash(String key) {
    int h1, k1, i, top, len;

    len = key.length;
    _len += len;

    k1 = _k1;
    i = 0;
    switch (_rem) {
      case 0:
        k1 ^= len > i ? (key.codeUnitAt(i++) & 0xffff) : 0;
        continue next1;
      next1:
      case 1:
        k1 ^= len > i ? (key.codeUnitAt(i++) & 0xffff) << 8 : 0;
        continue next2;
      next2:
      case 2:
        k1 ^= len > i ? (key.codeUnitAt(i++) & 0xffff) << 16 : 0;
        continue next3;
      next3:
      case 3:
        k1 ^= len > i ? (key.codeUnitAt(i) & 0xff) << 24 : 0;
        k1 ^= len > i ? (key.codeUnitAt(i++) & 0xff00) >> 8 : 0;
        break;
    }

    _rem = (len + _rem) & 3; // & 3 is same as % 4
    len -= _rem;
    if (len > 0) {
      h1 = _h1;
      while (1) {
        k1 = (k1 * 0x2d51 + (k1 & 0xffff) * 0xcc9e0000) & 0xffffffff;
        k1 = (k1 << 15) | (k1.toUnsigned(64) >> 17);
        k1 = (k1 * 0x3593 + (k1 & 0xffff) * 0x1b870000) & 0xffffffff;

        h1 ^= k1;
        h1 = (h1 << 13) | (h1.toUnsigned(64) >> 19);
        h1 = (h1 * 5 + 0xe6546b64) & 0xffffffff;

        if (i >= len) {
          break;
        }

        k1 = ((key.codeUnitAt(i++) & 0xffff)) ^
            ((key.codeUnitAt(i++) & 0xffff) << 8) ^
            ((key.codeUnitAt(i++) & 0xffff) << 16);
        top = key.codeUnitAt(i++);
        k1 ^= ((top & 0xff) << 24) ^ ((top & 0xff00) >> 8);
      }

      k1 = 0;
      switch (_rem) {
        case 3:
          k1 ^= (key.codeUnitAt(i + 2) & 0xffff) << 16;
          continue next2;
        next2:
        case 2:
          k1 ^= (key.codeUnitAt(i + 1) & 0xffff) << 8;
          continue next1;
        next1:
        case 1:
          k1 ^= (key.codeUnitAt(i) & 0xffff);
          break;
      }

      _h1 = h1;
    }

    _k1 = k1;
  }

  int result() {
    var k1, h1;

    k1 = _k1;
    h1 = _h1;

    if (k1 > 0) {
      k1 = (k1 * 0x2d51 + (k1 & 0xffff) * 0xcc9e0000) & 0xffffffff;
      k1 = (k1 << 15) | (k1.toUnsigned(64) >> 17);
      k1 = (k1 * 0x3593 + (k1 & 0xffff) * 0x1b870000) & 0xffffffff;
      h1 ^= k1;
    }

    h1 ^= _len;

    h1 ^= h1.toUnsigned(64) >> 16;
    h1 = (h1 * 0xca6b + (h1 & 0xffff) * 0x85eb0000) & 0xffffffff;
    h1 ^= h1.toUnsigned(64) >> 13;
    h1 = (h1 * 0xae35 + (h1 & 0xffff) * 0xc2b20000) & 0xffffffff;
    h1 ^= h1.toUnsigned(64) >> 16;

    return h1.toUnsigned(64);
  }

  void reset({int seed}) {
    _h1 = seed ?? 0;
    _rem = _k1 = _len = 0;
  }
}
