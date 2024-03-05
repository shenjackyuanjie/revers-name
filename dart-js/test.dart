// js
import 'dart:js' as Js;
import 'dart:html';

void main() {
  // Find an element by id (an-id).
  Element idElement = querySelector('#an-id')!;

// Find an element by class (a-class).
  Element classElement = querySelector('.a-class')!;

// Find all elements by tag (<div>).
  List<Element> divElements = querySelectorAll('div');


  print(idElement);
  print(classElement);
  print(divElements);
  querySelector('#inputs')!.nodes.add(idElement);

  print("Hello, World!");
  var a = "Hello, World!";
  for (var i = 0; i < 10; i++) {
    a += " " + i.toString();
  }
  int b = 124242424;
  for (var i = 0; i < 10; i++) {
    b += b * i;
  }
  // js sleep
  Future.delayed(Duration(milliseconds: 1000)).then((value) {
    print("延时1秒执行 then ");
    print(value);
  });

  var closuer = () {
    print("closuer");
  };
  closuer();
  print(a);
}
