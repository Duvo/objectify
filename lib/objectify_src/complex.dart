part of objectify;

dynamic _handleComplexType(Type rootType, dynamic data) {
  var classMirror = reflectClass(rootType);
  var instanceMirror = classMirror.newInstance(new Symbol(''), []);
  var declarations = classMirror.declarations.values.where((declaration) =>
      (declaration is VariableMirror
        && !declaration.isConst && !declaration.isFinal
        && !declaration.isPrivate && !declaration.isStatic));
  declarations.foreach((VariableMirror variableMirror) {
    // TODO
  });

}