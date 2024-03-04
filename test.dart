// js
import 'dart:js' as js;

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
  // js sleep 
    Future.delayed(Duration(milliseconds:1000)).then((value){
      print("延时1秒执行 then ");
      print(value);
    });
  print(a);
}