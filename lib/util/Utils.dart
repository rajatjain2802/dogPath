import 'dart:io';

// Check Internet Connection
Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

// check Map and if null fill with ""
String getFieldValue(Map map, String key) {
  String str = '';
  if (map.containsKey(key)) {
    String s = map[key];
    if (s != null) {
      str = s.toString();
    }
  }
  return str;
}

int getFieldValueInteger(Map map, String key) {
  int value = 0;
  if (map.containsKey(key)) {
    int s = map[key];
    if (s != null) {
      value = s;
    }
  }
  return value;
}
