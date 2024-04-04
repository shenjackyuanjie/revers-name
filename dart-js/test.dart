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

b_run() async {
  print("object in b_run");
  await md5run();
  await async_catch();
  print("object after 1s");
}

md5run() async {
  print("object in md5run");
  await Future.delayed(Duration(milliseconds: 1000));
  print("object in md5run after 1s");
}

a_async_throw() async {
  throw "a_async_throw";
}

async_catch() async {
  try {
    await a_async_throw();
  } catch (e) {
    print(e);
  }
}

a_run() async {
  print("object");
  await md5run();
  await b_run();
  print("object after 1s");
}

void test() {
  print("test");
}

void main() {
  print(test_list("abc"));
  print(test_list(""));

  print(Dt.at);

  var reg_exp = RegExp(r"^\d{1,2}$");

  print(reg_exp.hasMatch("1"));

  // Find an element by id (an-id).
  Element idElement = querySelector('#an-id')!;

  // Find an element by class (a-class).
  Element classElement = querySelector('.a-class')!;

  classElement.addEventListener('click', (event) {
    print("click");
  });

  // Find all elements by tag (<div>).
  List<Element> divElements = querySelectorAll('div');

  List<double> double_list = [1.0, 2.0, 3.0, 5.0, 5.002];

  // range in list
  print(double_list.getRange(0, 2).toList());

  // range
  var range = List.generate(5, (index) => index);
  print(range);
  print(double_list.getRange(Range.END_TO_START, Range.START_TO_END).toList());

  // 增删改查
  double_list.add(4.0);
  double_list.removeAt(0);
  double_list[0] = 5.0;
  print(double_list[0]);

  // 遍历
  double_list.forEach((element) {
    print(element);
  });

  // call setTimeout
  Js.context.callMethod('setTimeout', [Js.allowInterop(() {
    print("延时1秒执行");
  }), 1000]);

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
  // window.parent.postMessage
  window.parent?.postMessage("什么奇怪东西", "*");

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
