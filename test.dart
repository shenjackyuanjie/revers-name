void main() {
  print("Hello, World!");
  var a = "Hello, World!";
  for (var i = 0; i < 10; i++) {
    a += " " + i.toString();
  }
  var b = 12242424242424;
  for (var i = 0; i < 10; i++) {
    b += b*i;
  }
  print(a);
}