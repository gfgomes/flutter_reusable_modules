import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String convertIntoBase64(File file) {
  return base64Encode(file.readAsBytesSync());
}

Image imageFromBase64String(String base64String) {
  Uint8List bytes = base64Decode(base64String);
  return Image.memory(bytes);
}

String formatDateTime(DateTime dateTime) {
  initializeDateFormatting();

  DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
  return dateFormat.format(dateTime);
}
