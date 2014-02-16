part of objectify;

bool isDynamicType(Type type) {
  return type == dynamic || type == null || type == Object;
}

bool isArrayType(Type type) {
  return hasSuperclass(type, List) || hasSuperclass(type, Set)
      || hasSuperclass(type, Map); 
}

bool isSimpleType(Type type) {
  return hasSuperclass(type, num) || hasSuperclass(type, String)
      || hasSuperclass(type, bool);
}

bool hasSuperclass(Type type, Type supertype) {  
  var classMirror = reflectClass(type);
  var superClassMirror = reflectClass(supertype);
  while(classMirror != null) {
    if (!classMirror.isOriginalDeclaration) {
      classMirror = classMirror.originalDeclaration;
    }
    if (classMirror == superClassMirror) return true;
    classMirror = classMirror.superclass;
  }
  return false;
}