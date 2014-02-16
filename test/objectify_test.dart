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
                     'mapComplexVar': {'num1': complex1, 'num2': complex2}};

const TEST_TOOL = true;
const TEST_SIMPLE = true;
const TEST_COMPLEX = true;

main() {
  if (TEST_TOOL) {
    group('Tools', () {
      test('hasSuperclass', () {
        expect(hasSuperclass(List, List), isTrue, reason: 'List - List');
        expect(hasSuperclass(int, num), isTrue, reason: 'int - num');
        expect(hasSuperclass(num, int), isFalse, reason: 'num - int');
        expect(hasSuperclass(Simple, String), isFalse, reason: 'Simple - String');
      });
      test('isSimpleType', () {
        expect(isSimpleType(String), isTrue, reason: 'String');
        expect(isSimpleType(num), isTrue, reason: 'num');
        expect(isSimpleType(int), isTrue, reason: 'int');
        expect(isSimpleType(double), isTrue, reason: 'double');
        expect(isSimpleType(bool), isTrue, reason: 'bool');
        expect(isSimpleType(List), isFalse, reason: 'List');
        expect(isSimpleType(Map), isFalse, reason: 'Map');
        expect(isSimpleType(Set), isFalse, reason: 'Set');
        expect(isSimpleType(Complex), isFalse, reason: 'Complex');
        expect(isSimpleType(Object), isFalse, reason: 'Complex');
      });
      test('isArrayType', () {
        expect(isArrayType(bool), isFalse, reason: 'bool');
        expect(isArrayType(List), isTrue, reason: 'List');
        expect(isArrayType(Map), isTrue, reason: 'Map');
        expect(isArrayType(Set), isTrue, reason: 'Set');
        expect(isArrayType(Complex), isFalse, reason: 'Complex');
        expect(isArrayType(Object), isFalse, reason: 'Complex');
      });
      test('isDynamicType', () {
        expect(isDynamicType(bool), isFalse, reason: 'bool');
        expect(isDynamicType(List), isFalse, reason: 'List');
        expect(isDynamicType(Map), isFalse, reason: 'Map');
        expect(isDynamicType(Set), isFalse, reason: 'Set');
        expect(isDynamicType(Complex), isFalse, reason: 'Complex');
        expect(isDynamicType(dynamic), isTrue, reason: 'Complex');
        expect(isDynamicType(Object), isTrue, reason: 'Complex');
        expect(isDynamicType(null), isTrue, reason: 'Complex');
      });
    });
  }
  
  if (TEST_SIMPLE) {
    group('Simples types', () {
      var objectifyNum = new Objectify<num>();
      var objectifyInt = new Objectify<int>();
      var objectifyDouble = new Objectify<double>();
      var objectifyString = new Objectify<String>();
      var objectifyBool = new Objectify<bool>();
      var objectifyList = new Objectify<List>();
      var objectifyMap = new Objectify<Map>();
      var objectifySet = new Objectify<Set>();
      
      test('num', () {        
        expect(objectifyNum.convert(1), 1);
        expect(objectifyNum.convert(1.5), 1.5);
        expect(objectifyNum.convert('2'), 2);
        expect(objectifyNum.convert('2.5'), 2.5);
        
        expect(objectifyInt.convert(3), 3);
        expect(objectifyInt.convert('4'), 4);
        expect(objectifyInt.convert(5.1), 5);
        expect(objectifyInt.convert('6.1'), 6);
        expect(objectifyInt.convert(6.8), 7);
        expect(objectifyInt.convert('7.8'), 8);
        
        expect(objectifyDouble.convert(8.5), 8.5);
        expect(objectifyDouble.convert('9.5'), 9.5);
        expect(objectifyDouble.convert(10), 10.0);
        expect(objectifyDouble.convert('11'), 11.0);
      });
      test('String', () {        
        expect(objectifyString.convert('foo').toString(), 'foo');
        expect(objectifyString.convert(1).toString(), '1');
        expect(objectifyString.convert(true).toString(), 'true');
      });
      test('bool', () {        
        expect(objectifyBool.convert(true), isTrue);
        expect(objectifyBool.convert(false), isFalse);
        expect(objectifyBool.convert('true'), isTrue);
        expect(objectifyBool.convert('false'), isFalse);
        expect(objectifyBool.convert(1), isTrue);
        expect(objectifyBool.convert(0), isFalse);
      });
      test('Null', () {
        expect(objectifyString.convert(null), isNull, reason: 'Null string');
        expect(objectifyInt.convert(null), isNull, reason: 'Null int');
        expect(objectifyDouble.convert(null), isNull, reason: 'Null double');
        expect(objectifyBool.convert(null), isNull, reason: 'Null bool');
      });
      test('List', () {
        expect(objectifyList.convert([true, 1, 2.0, 'foo', null, [1, 2, 3], {'1':1}]),
            [true, 1, 2.0, 'foo', null, [1, 2, 3], {'1':1}]);
      });
      test('Map', () {
        expect(objectifyMap.convert({'foo': 'bar', 2: '2'}), {'foo': 'bar', 2: '2'});
        expect(objectifyMap.convert(['foo', 'bar']), {0: 'foo', 1: 'bar'});
      });
      test('Set', () {
        expect(objectifySet.convert(['foo', 'bar']), new Set.from(['foo', 'bar']));
      });
    });
  }

  if (TEST_COMPLEX) {
    group('Complex types', () {
      var objectifySimple = new Objectify<Simple>();
      var objectifyComplex = new Objectify<Complex>();
      var objectifyGenericString = new Objectify<Generic<String>>();
      var objectifyGenericSimple = new Objectify<Generic<Simple>>();
      var objectifySuper = new Objectify<SuperComplex>();
      
      test('Simple', () {
        Simple simple = objectifySimple.convert(simple1);        
        checkSimple(simple, simple1);
      });
      test('Complex', () {
        Complex complex = objectifyComplex.convert(complex1);        
        checkComplex(complex, complex1);
      });
      test('Generic', () {
        Generic gen1 = objectifyGenericString.convert(generic1);
        checkGeneric(gen1, generic1);
        Generic gen2 = objectifyGenericSimple.convert(generic2);
        checkGeneric(gen2, generic2); 
      });
      test('Super complex', () {
        SuperComplex superComplex = objectifySuper.convert(superComplex1);
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

void checkSuperComplex(SuperComplex superComplexObject, dynamic superComplexArray) {
  expect(superComplexObject, new isInstanceOf<SuperComplex>('SuperComplex'));
  expect(superComplexObject.setSimpleVar.first, new isInstanceOf<Simple>('Simple'));
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