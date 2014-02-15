import 'package:unittest/unittest.dart';
import 'package:objectify/objectify.dart';

class Simple {
  String stringVar;
  int intVar;
  double doubleVar;
  num numVar;
  Object objectVar;
  var varVar;
  dynamic dynamicVar;
  List listVar;
  Map mapVar;
  String nullVar;
  String absentVar;
  Set setVar;
}

var simple1 = {'stringVar': 'foobar',
               'intVar': 10,
               'doubleVar': 2.5,
               'numVar': 20,
               'objectVar': [1, 2, 'foo'],
               'varVar': {'foo': 'bar'},
               'dynamicVar': [1, 2, [1, 2], {'foo': 'bar'}],
               'listVar': [1, 2, 3],
               'mapVar': {'foo': 'fooVal', 'bar': 'barVal'},
               'nullVar': null,
               'setVar': [1, 2, 3]
               };

var simple2 = {'stringVar': 'foo',
               'intVar': 20,
               'doubleVar': 5.5,
               'numVar': 2.3,
               'objectVar': 'foobar',
               'varVar': [1, 2, 3],
               'dynamicVar': [1, 2],
               'listVar': [1],
               'mapVar': {'foo': 'foo'},
               'nullVal': null
               };

class Complex {
  Simple simpleVar;
}

var complex1 = {'simpleVar': simple1};
var complex2 = {'simpleVar': simple2};

class Generic<T> {
  T tVar;
  List<T> listTVar;
}

var generic1 = {'tVar': 'stringValue', 'listTVar': ['foo', 'bar']};
var generic2 = {'tVar': simple1, 'listTVar': [simple1, simple2]};

class SuperComplex {
  Set<Simple> setSimpleVar;
  List<int> listIntVar;
  Map<String, String> mapStringVar;
  Map<int, String> mapIntVar;
  List<String> listStringVar;
  List<Simple> listSimpleVar;
  Map<String, Complex> mapComplexVar;  
}

var superComplex1 = {'setSimpleVar': [simple1, simple2],
                     'listIntVar': [1, 2, 3],
                     'mapStringVar': {'foo': 'foo', 'bar': 'bar'},
                     'mapIntVar': {1: 'one', 2: 'two', 3: 'three'},
                     'listStringVar': ['foo', 'bar', 'foobar'],
                     'listSimpleVar': [simple1, simple2],
                     'listComplexVar': {'num1': complex1, 'num2': complex2}};

const TEST_SIMPLE = false;
const TEST_COMPLEX = true;

main() {
  group('Tools', () {
    test('isSubclassOf', () {
      expect(isSubclassOf(List, List), isTrue, reason: 'List - List');
      var temp = new List<String>();
      expect(isSubclassOf(temp.runtimeType, List), isTrue, reason: 'List<String> - List');
      temp = 15;
      expect(isSubclassOf(temp.runtimeType, num), isTrue, reason: 'int - num');
      expect(isSubclassOf(List, List), isTrue, reason: 'List - List');
      expect(isSubclassOf(List, List), isTrue, reason: 'List - List');
    });
  });
  
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
        expect(objectify(Map, ['foo', 'bar']), {0: 'foo', 1: 'bar'});
      });
      test('Set', () {
        expect(objectify(Set, ['foo', 'bar']), new Set.from(['foo', 'bar']));
      });
    });
  }

  if (TEST_COMPLEX) {
    group('Complex types', () {
      /*test('Simple', () {
        Simple simple = objectify(Simple, simple1);        
        checkSimple(simple, simple1);
      });
      test('Complex', () {
        Complex complex = objectify(Complex, complex1);        
        checkComplex(complex, complex1);
      });*/
      test('Generic', () {
        Generic generic = objectify(Generic, generic1);
        checkGeneric(generic, generic1);           
      });
      test('Super complex', () {
        SuperComplex superComplex = objectify(SuperComplex, superComplex1);        
        checkSuperComplex(superComplex, superComplex1);
      });
    });
  }
}

void checkSimple(Simple simpleObject, dynamic simpleArray) {
  expect(simpleObject, new isInstanceOf<Simple>('Simple'));
  expect(simpleObject.absentVar, isNull);
  expect(simpleObject.nullVar, isNull);
  expect(simpleObject.doubleVar, simpleArray['doubleVar']);
  expect(simpleObject.dynamicVar, simpleArray['dynamicVar']);
  expect(simpleObject.intVar, simpleArray['intVar']);
  expect(simpleObject.listVar, simpleArray['listVar']);
  expect(simpleObject.mapVar, simpleArray['mapVar']);  
  expect(simpleObject.numVar, simpleArray['numVar']);
  expect(simpleObject.objectVar, simpleArray['objectVar']);
  expect(simpleObject.stringVar, simpleArray['stringVar']);
  expect(simpleObject.varVar, simpleArray['varVar']);
  expect(simpleObject.setVar, simpleArray['setVar']);
}

void checkComplex(Complex complexObject, dynamic complexArray) {
  expect(complexObject, new isInstanceOf<Complex>('Complex'));
  checkSimple(complexObject.simpleVar, complexArray['simpleVar']);
}

void checkGeneric(Generic genericObject, dynamic genericArray) {
  expect(genericObject, new isInstanceOf<Generic>('Generic'));
  if (genericObject is Generic<String>) {
    expect(genericObject.tVar, genericArray['tVar']);
    expect(genericObject.listTVar, genericArray['listTVar']);
  } else if (genericObject is Generic<Simple>) {
    checkSimple(genericObject.tVar, genericArray['tVar']);
    for(var i=0; i<genericArray['listTVar'].length; i++) {
      checkSimple(genericObject.listTVar[i], genericArray['listTVar'][i]);
    }
  }
}

void checkSuperComplex(SuperComplex superComplexObject,
                       dynamic superComplexArray) {
  expect(superComplexObject, new isInstanceOf<SuperComplex>('SuperComplex'));
  expect(superComplexObject.setSimpleVar,
      new isInstanceOf<Set<Simple>>('Set<Simple>'));
  for (var i=0; i<superComplexArray['setSimpleVar'].length; i++) {
    var simpleVar = superComplexObject.setSimpleVar.elementAt(i);
    checkSimple(simpleVar, superComplexArray['setSimpleVar'][i]);
  }  
  expect(superComplexObject.listIntVar,
      new isInstanceOf<List<int>>('List<int>'));
  expect(superComplexObject.listIntVar, superComplexArray['listIntVar']);
  expect(superComplexObject.mapStringVar,
      new isInstanceOf<Map<String, String>>('Map<String, String>'));
  expect(superComplexObject.mapStringVar, superComplexArray['mapStringVar']);
  expect(superComplexObject.mapIntVar,
      new isInstanceOf<Map<int, String>>('Map<int, String>'));
  expect(superComplexObject.mapIntVar, superComplexArray['mapIntVar']);
  expect(superComplexObject.listStringVar,
      new isInstanceOf<List<String>>('List<String>'));
  expect(superComplexObject.listStringVar, superComplexArray['listStringVar']);
  expect(superComplexObject.listSimpleVar,
      new isInstanceOf<List<Simple>>('List<Simple>'));
  for (var i=0; i<superComplexArray['listSimpleVar'].length; i++) {
    var simpleVar = superComplexObject.listSimpleVar[i];
    checkSimple(simpleVar, superComplexArray['listSimpleVar'][i]);
  }  
  expect(superComplexObject.mapComplexVar,
      new isInstanceOf<Map<String, Complex>>('Map<String, Complex>'));
  superComplexArray['mapComplexVar'].forEach((key, complexVar) {
    checkComplex(superComplexObject.mapComplexVar[key], complexVar);
  });  
}