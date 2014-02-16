part of objectify;

dynamic _handleSimpleType(Type type, dynamic data) {
  if (hasSuperclass(type, String)) {
    return data.toString();
  }
  if (hasSuperclass(type, int)) {
    if (data is num) return data.round();
    if (data is bool) return data ? 1 : 0;
    if (data is String) return num.parse(data).round();
  }
  if (hasSuperclass(type, double)) {
    if (data is num) return data.toDouble();
    if (data is bool) return data ? 1.0 : 0.0;
    if (data is String) return num.parse(data).toDouble();
  }
  if (hasSuperclass(type, num)) {
    if (data is num) return data;
    if (data is bool) return data ? 1 : 0;
    if (data is String) return num.parse(data);
  }    
  if (hasSuperclass(type, bool)) {
    if (data is bool) return data;
    if (data is String) return data.toLowerCase() == 'true';
    if (data is num) return data == 1;
  } 
  
  throw type.toString() + ' is not that simple.';
}

dynamic _handleArrayType(Type type, dynamic data) {
  var typeMirror = reflectType(type);
  if (hasSuperclass(type, List) && data is List) {
    if (typeMirror.isOriginalDeclaration) {
      return data;
    } else {
      var typeArgument = typeMirror.typeArguments.first;
      if (typeArgument is ClassMirror) {
        return new List.generate(data.length, (index) {
          return _convert(typeArgument.reflectedType, data[index]);
        }, growable: true);
      } else {
        return data;
      }      
    }    
  }
  
  if (hasSuperclass(type, Map)) {
    if (!typeMirror.isOriginalDeclaration) {
      var typeKey = typeMirror.typeArguments[0];
      var typeValue = typeMirror.typeArguments[1];
      if (typeKey is ClassMirror && typeValue is ClassMirror) {
        var map = {};
        if (data is Map) {
          data.forEach((key, value) {
            map[_convert(typeKey.reflectedType, key)] = _convert(typeValue.reflectedType, value);
          });
        } else if (data is List) {
          for (var i=0; i<data.length; i++) {
            map[_convert(typeKey, i)] = _convert(typeValue, data[i]);
          }
        }
        return map;
      }
    }
    if (data is Map) {
      return data;
    } else if (data is List) {
      return data.asMap();
    }
  }
  
  if (hasSuperclass(type, Set) && data is List) {
    if (!typeMirror.isOriginalDeclaration) {
      var typeArgument = typeMirror.typeArguments.first;
      if (typeArgument is ClassMirror) {
        var list = new List.generate(data.length, (index) {
          return _convert(typeArgument.reflectedType, data[index]);
        }, growable: true);
        return new Set.from(list);
      }
    }
    return new Set.from(data);
  }  
}

dynamic _handleComplexType(Type type, dynamic data) {
  var typeMirror = reflectType(type);
  var instanceMirror = typeMirror.newInstance(new Symbol(''), []);
  var variableMirrors = typeMirror.declarations.values.where((declaration) =>
      (declaration is VariableMirror && !declaration.isConst &&
          !declaration.isFinal && !declaration.isPrivate &&
          !declaration.isStatic));
  variableMirrors.forEach((variableMirror) {      
    var simpleName = MirrorSystem.getName(variableMirror.simpleName);
    var value = data[simpleName];
    var type = variableMirror.type;
    if (type is ClassMirror && type.hasReflectedType) {
      instanceMirror.setField(variableMirror.simpleName,
          _convert(type.reflectedType, value));                      
    } else {
      instanceMirror.setField(variableMirror.simpleName,
          _convert(null, value));
    }            
  });  
  
  return instanceMirror.reflectee;
}