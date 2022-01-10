import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image/image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_network/models/decode_param.dart';
import 'package:social_network/services/image_picker_service.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerService imagePickerService;
  final _receivePort = ReceivePort();

  ImagePickerBloc({required this.imagePickerService})
      : super(NoImagePickedState()) {
    on<PickCameraImageEvent>(_pickCameraImage);
    on<PickGalleryImageEvent>(_pickGalleryImage);
    on<ResetImageEvent>(_resetImage);
  }

  FutureOr<void> _pickCameraImage(_, Emitter<ImagePickerState> emit) async {
    emit(LoadingImageState());
    final sourceFile = await imagePickerService.pickImageFromCamera();

    if (sourceFile != null) {
      final destinationFile = await _spawnIsolate(sourceFile);
      emit(PickedImageState(destinationFile));
    } else {
      emit(NoImagePickedState());
    }
  }

  FutureOr<void> _pickGalleryImage(_, Emitter<ImagePickerState> emit) async {
    emit(LoadingImageState());
    final sourceFile = await imagePickerService.pickImageFromGallery();

    if (sourceFile != null) {
      final destinationFile = await _spawnIsolate(sourceFile);
      emit(PickedImageState(destinationFile));
    } else {
      emit(NoImagePickedState());
    }
  }

  void _resetImage(_, Emitter<ImagePickerState> emit) =>
      emit(NoImagePickedState());

  Future<File> _spawnIsolate(File sourceFile) async {
    final imageFolder = await getTemporaryDirectory();
    final destinationFile = File(join(imageFolder.path, 'thumbnail.png'));

    await Isolate.spawn(
      resizeImage,
      DecodeParam(
        source: sourceFile,
        destination: destinationFile,
        port: _receivePort.sendPort,
      ),
    );

    return destinationFile;
  }

  static void resizeImage(DecodeParam param) {
    final image = decodeImage(param.source.readAsBytesSync());
    final thumbnail = copyResize(image!, width: 300);

    param.destination.writeAsBytesSync(encodePng(thumbnail));
    param.port.send(null);
  }

  void pickCameraImage() => add(PickCameraImageEvent());

  void pickGalleryImage() => add(PickGalleryImageEvent());

  void reset() => add(ResetImageEvent());
}
