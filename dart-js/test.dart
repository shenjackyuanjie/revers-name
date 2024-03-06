// js
import 'dart:js' as Js;
import 'dart:html';

abstract class IPlr {}

class NPlr extends IPlr {}

SpanElement Span(String cls) {
  return new SpanElement()..classes.add(cls);
}

DivElement Div(String cls) {
  return new DivElement()..classes.add(cls);
}

TableCellElement TD(TableRowElement tr) {
  TableCellElement td = new TableCellElement();
  tr.append(td);
  return td;
}

ParagraphElement P(String cls) {
  return new ParagraphElement()..classes.add(cls);
}

String b(String str) {
  return str;
}

String smile(String str) {
  return '<div class="smile s_$str"></div>';
}

String l(String str, String key) {
  return str;
}

num drawText(CanvasRenderingContext2D ctx, String txt, int x, int y, int w,
    bool center) {
  TextMetrics tm = ctx.measureText(txt);
  ctx.fillText(txt, x, y + 15, w);
  return 1;
}

class Dt {

  static String ex = b('!');
  static String add = b('+');
  static String at = b('@');
}


void main() {

  print(Dt.at);

  // Find an element by id (an-id).
  Element idElement = querySelector('#an-id')!;

// Find an element by class (a-class).
  Element classElement = querySelector('.a-class')!;

// Find all elements by tag (<div>).
  List<Element> divElements = querySelectorAll('div');

  Map test_map = {
    "a": 1,
  };

  print(test_map);

  TableRowElement tr = new TableRowElement();
  TD(tr)
    ..text = l('击杀', 'killedCount')
    ..style.width = '44px';
  TD(tr)
    ..text = l('致命一击', 'killerName')
    ..style.minWidth = '112px';

  var plr = new NPlr();

  DivElement plist = document.querySelector('.plist') as DivElement;
  DivElement pbody = document.querySelector('.pbody') as DivElement;

  DivElement p = Div('p');

  p.append(tr);
  pbody.append(p);
  plist.append(pbody);

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

