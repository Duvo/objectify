part of objectify;

dynamic _handleComplexType(Type rootType, dynamic data) {
  var classMirror = reflectClass(rootType);
  var instanceMirror = classMirror.newInstance(new Symbol(''), []);
  if (classMirror.typeArguments.isEmpty) {
    var variableMirrors = classMirror.declarations.values.where((declaration) =>
        (declaration is VariableMirror && !declaration.isConst &&
            !declaration.isFinal && !declaration.isPrivate &&
            !declaration.isStatic));
    variableMirrors.forEach((variableMirror) {      
      var simpleName = MirrorSystem.getName(variableMirror.simpleName);
      var value = data[simpleName];
      var type = variableMirror.type;
      if (type is ClassMirror && type.hasReflectedType) {
        instanceMirror.setField(variableMirror.simpleName,
            objectify(type.reflectedType, value));                      
      } else {
        instanceMirror.setField(variableMirror.simpleName,
            objectify(null, value));
      }            
    });
  }
  
  
  return instanceMirror.reflectee;  

}