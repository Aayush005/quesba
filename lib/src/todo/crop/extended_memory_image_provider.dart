import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui show Codec;

import 'package:ml_text_recognition/src/todo/crop/extended_image_provider.dart';

class ExtendedMemoryImageProvider extends MemoryImage
    with ExtendedImageProvider {
  ExtendedMemoryImageProvider(Uint8List bytes, {double scale = 1.0})
      : super(bytes, scale: scale);

  @override
  ImageStreamCompleter load(MemoryImage key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: key.scale,
    );
  }

  Future<ui.Codec> _loadAsync(MemoryImage key, DecoderCallback decode) {
    assert(key == this);
    return instantiateImageCodec(bytes, decode);
  }

  @override
  Uint8List get rawImageData => bytes;
}
