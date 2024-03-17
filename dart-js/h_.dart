

String h_(String str) {
  int a = 1;
  int b = 3;
  int c = 5;
  int d = 7;
  for (int n in str.codeUnits) {
    a = (a + n + d) * 17 % 52;
    b = (b + n * a) * 23 % 52;
    c = (c + n + b) * 47 % 52;
    d = (d + n * c) * 41 % 52;
  }
  if (a < 26) a += 65;
    else a += 71;
  if (b < 26) b += 65;
    else b += 71;
  if (c < 26) c += 65;
    else c += 71;
  if (d < 26) d += 65;
      else d += 71;
  return new String.fromCharCodes([a, b, c, d]);
}

void main(List<String> args) {
  // 对于每一个输入 都混淆一遍再输出

  for (String arg in args) {
    print(arg + " -> " + h_(arg));
  }
}