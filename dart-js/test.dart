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

List<String> test_list(String str) {
  // spilt with ""
  str = str.split("").join("");

  // if empty -> return []
  if (str.isEmpty) {
    return [];
  }

  return ["a", "b", "c"];

}

md5run() async{
  print("object in md5run");
  await Future.delayed(Duration(milliseconds: 1000));
  print("object in md5run after 1s");
}

a_run() async{
  print("object");
  await md5run();
  print("object after 1s");
}

void main() {

  print(test_list("abc"));
  print(test_list(""));

  print(Dt.at);

  // Find an element by id (an-id).
  Element idElement = querySelector('#an-id')!;

// Find an element by class (a-class).
  Element classElement = querySelector('.a-class')!;

// Find all elements by tag (<div>).
  List<Element> divElements = querySelectorAll('div');

  Map<String, int> test_map = {
    "a": 1,
  };

  a_run();

  // 插入
  test_map["b"] = 2;
  
  // 删除
  test_map.remove("a");
  
  // 修改
  test_map["b"] = 3;
  
  // 查找
  print(test_map["b"]);
  // 遍历
  test_map.forEach((key, value) {
    print("$key : $value");
  });
  // 长度
  print(test_map.length);
  // 是否为空
  print(test_map.isEmpty);
  // 是否不为空
  print(test_map.isNotEmpty);
  // 是否包含key
  print(test_map.containsKey("b"));
  // 是否包含value
  print(test_map.containsValue(3));
  // 转换为list
  print(test_map.keys.toList());
  print(test_map.values.toList());
  // 转换为json
  print(test_map.toString());
  // 清空
  test_map.clear();

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

