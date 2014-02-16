library objectify;

import 'dart:mirrors';

part 'objectify_src/handlers.dart';
part 'objectify_src/tools.dart';

class Objectify<T> {
  T convert(dynamic data) {
    return _convert(T, data);
  }
}

dynamic _convert(Type type, dynamic data) {
  if (data == null) return null;
  if (isDynamicType(type)) return data;
  if (isSimpleType(type)) return _handleSimpleType(type, data);
  if (isArrayType(type)) return _handleArrayType(type, data);
  return _handleComplexType(type, data);
}