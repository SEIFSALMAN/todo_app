import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final dateProvider = StateProvider<String>((ref) {
  return '${DateFormat('yMd').format(DateTime.now())}';
});


final timeProvider = StateProvider<String>((ref) {
  return '${DateFormat("hh:mm a").format(DateTime.now())}';
});
