library objectify;

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
}