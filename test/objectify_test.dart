import 'package:unittest/unittest.dart';
import 'package:objectify/objectify.dart';

main() {
  objectifyDebug = true;
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
  });

}