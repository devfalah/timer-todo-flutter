import 'package:intl/intl.dart';

var now = DateTime.now();
var formatter = new DateFormat('yyyy.MM.dd');
String formatted = formatter.format(now);
