part of objectify;

dynamic _handleSimpleType(Type rootType, dynamic data) {
  if (rootType == String) {
    return data.toString();
  }

  if (rootType == num) {
    if (data is num) return data;
    if (data is bool) return data ? 1 : 0;
    if (data is String) return num.parse(data);
  }

  if (rootType == int) {
    if (data is num) return data.round();
    if (data is bool) return data ? 1 : 0;
    if (data is String) return num.parse(data).round();
  }

  if (rootType == double) {
    if (data is num) return data.toDouble();
    if (data is bool) return data ? 1.0 : 0.0;
    if (data is String) return num.parse(data).toDouble();
  }

  if (rootType == bool) {
    if (data is bool) return data;
    if (data is String) return data.toLowerCase() == 'true';
    if (data is num) return data == 1;
  }

  if (rootType == List && data is List) return data;
  if (rootType == Map && data is Map) return data;
}