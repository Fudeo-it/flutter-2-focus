import 'dart:io';
import 'dart:isolate';

class DecodeParam {
  final File source;
  final File destination;
  final SendPort port;

  DecodeParam({
    required this.source,
    required this.destination,
    required this.port,
  });
}
