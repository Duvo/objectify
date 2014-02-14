import 'package:unittest/unittest.dart';
import 'package:objectify/objectify.dart';

class Foobar {
  Foo foo;
  List<Bar> bars;
  var unknow;
}

class Foo {
  String foo;
}

class Bar {
  int bar;
}

const TEST_SIMPLE = false;
const TEST_COMPLEX = true;

main() {
  if (TEST_SIMPLE) {
    group('Simples types', () {
      test('num', () {
        expect(objectify(num, 1), 1);
        expect(objectify(num, 1.5), 1.5);
        expect(objectify(num, '2'), 2);
        expect(objectify(num, '2.5'), 2.5);

        expect(objectify(int, 3), 3);
        expect(objectify(int, '4'), 4);
        expect(objectify(int, 5.1), 5);
        expect(objectify(int, '6.1'), 6);
        expect(objectify(int, 6.8), 7);
        expect(objectify(int, '7.8'), 8);

        expect(objectify(double, 8.5), 8.5);
        expect(objectify(double, '9.5'), 9.5);
        expect(objectify(double, 10), 10.0);
        expect(objectify(double, '11'), 11.0);

      });
      test('String', () {
        expect(objectify(String, 'foo').toString(), 'foo');
        expect(objectify(String, 1).toString(), '1');
        expect(objectify(String, true).toString(), 'true');
      });
      test('bool', () {
        expect(objectify(bool, true), isTrue);
        expect(objectify(bool, false), isFalse);
        expect(objectify(bool, 'true'), isTrue);
        expect(objectify(bool, 'false'), isFalse);
        expect(objectify(bool, 1), isTrue);
        expect(objectify(bool, 0), isFalse);
      });
      test('Null', () {
        expect(objectify(String, null), isNull, reason: 'Null string');
        expect(objectify(int, null), isNull, reason: 'Null int');
        expect(objectify(double, null), isNull, reason: 'Null double');
        expect(objectify(bool, null), isNull, reason: 'Null bool');
      });
      test('List', () {
        expect(objectify(List, [true, 1, 2.0, 'foo', null, [1, 2, 3], {'1':1}]),
            [true, 1, 2.0, 'foo', null, [1, 2, 3], {'1':1}]);
      });
      test('Map', () {
        expect(objectify(Map, {'foo': 'bar', 2: '2'}), {'foo': 'bar', 2: '2'});
      });
    });
  }

  if (TEST_COMPLEX) {
    group('Complex types', () {
      test('Foo', () {
        var foo = objectify(Foo, {'foo': 'fooValue'});
        expect(foo, new isInstanceOf<Foo>());
        expect(foo.foo, 'fooValue');
      });
      test('Bar', () {
        var bar = objectify(Bar, {'bar': 10});
        expect(bar, new isInstanceOf<Bar>());
        expect(bar.bar, 10);
      });
      test('Foobar', () {
        var foobar = objectify(Foobar, {'foo': {'foo': 'fooValue'},
          'bars': [{'bar': 10}, {'bar': 20}],
          'unknow': 'stringValue'});
        expect(foobar, new isInstanceOf<Foobar>());
        expect(foobar.bars[1].bar, 20);
      });
    });
  }
}