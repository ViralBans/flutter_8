import 'package:flutter/services.dart';

Future<String> fetchFileFromAssets(String assetsPath) {
  return rootBundle.loadString('assets/$assetsPath').then((file) => file.toString());
}