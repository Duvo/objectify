library objectify;

import 'dart:mirrors';

part 'objectify_src/complex.dart';
part 'objectify_src/simple.dart';

bool objectifyDebug = false;

dynamic objectify(Type rootType, dynamic data, {bool debug: false}) {
  if (objectifyDebug || debug) {
    print('rootType: ' + rootType.toString() + ' - data: ' + data.toString());

    if (data is String) print (data.toString() + ' is String');
    if (data is num) print (data.toString() + ' is num');
    if (data is int) print (data.toString() + ' is int');
    if (data is double) print (data.toString() + ' is double');
    if (data is bool) print (data.toString() + ' is bool');
    if (data == null) print (data.toString() + ' == null');
    if (data is List) print (data.toString() + ' is List');
    if (data is Map) print (data.toString() + ' is Map');

    if (rootType == String) print (rootType.toString() + ' == String');
    if (rootType == int) print (rootType.toString() + ' == int');
    if (rootType == double) print (rootType.toString() + ' == double');
    if (rootType == num) print (rootType.toString() + ' == num');
    if (rootType == bool) print (rootType.toString() + ' == bool');
    if (rootType == List) print (rootType.toString() + ' == List');
    if (rootType == Map) print (rootType.toString() + ' == Map');
  }

  if (data == null) {
    return null;
  }
  if (rootType == dynamic || rootType == null || rootType == Object) {
    return data;
  }  
  if (rootType == String || rootType == num || rootType == int
      || rootType == double || rootType == bool || rootType == List
      || rootType == Map || rootType == Set) {
    return _handleSimpleType(rootType, data);
  }
  return _handleComplexType(rootType, data);
}

bool isSubclassOf(Type type, Type superType) {
  var classMirror = reflectClass(type);
  var instanceMirror = classMirror.newInstance('', []);
  var typeInstance = instanceMirror.reflectee;
  return (type is superType);
}