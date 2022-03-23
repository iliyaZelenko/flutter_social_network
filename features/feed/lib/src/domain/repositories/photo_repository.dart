import 'dart:typed_data';

abstract class PhotoRepository {
  Future<List<Uint8List>> readFiles(Iterable<String> paths);
}
