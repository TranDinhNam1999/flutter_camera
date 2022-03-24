import 'package:async/async.dart';
import 'gen/file_server.pb.dart';
import 'dart:io';
import 'dart:async';

const CHUNKSIZE = 1024 * 1024;

// ignore: non_constant_identifier_names
Stream<Chunk> get_file_chunks(filename) async* {
  //final reader = ChunkedStreamReader(filename);
  final reader = ChunkedStreamReader(File(filename).openRead());
  // While the reader has a next byte
  while (true) {
    var data = await reader.readChunk(CHUNKSIZE); // read one byte
    if (data.isEmpty) {
      return;
    }
    yield Chunk(buffer: data);
  }
}
