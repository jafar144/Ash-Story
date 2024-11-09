import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_intermediate/bloc/add_story/add_story_state.dart';
import 'package:submission_intermediate/data/api/api_service.dart';
import 'package:submission_intermediate/data/shared_preferences/preferences_helper.dart';

class AddStoryCubit extends Cubit<AddStoryState> {
  final ApiService apiService;
  final PreferencesHelper preferencesHelper;

  AddStoryCubit(
    this.apiService,
    this.preferencesHelper,
  ) : super(Idle());

  Future upload(
    List<int> bytes,
    String fileName,
    String description,
  ) async {
    emit(Loading());
    try {
      final compressedBytes = await _compressImageInIsolate(bytes);
      final token = await preferencesHelper.getTokenLogin();
      final result = await apiService.addNewStory(
        token,
        fileName,
        description,
        compressedBytes,
      );
      if (result.error == false) {
        emit(Success());
      } else {
        emit(Failed(error: result.message));
      }
    } on SocketException catch (e) {
      emit(Failed(error: e.message));
    } catch (e) {
      emit(Failed(error: e.toString()));
    }
  }

  Future<List<int>> _compressImageInIsolate(List<int> bytes) async {
    final receivePort = ReceivePort();

    await Isolate.spawn(_imageCompressionTask, receivePort.sendPort);

    final sendPort = await receivePort.first as SendPort;
    final response = ReceivePort();
    sendPort.send([bytes, response.sendPort]);

    return await response.first as List<int>;
  }

  static void _imageCompressionTask(SendPort mainSendPort) async {
    final port = ReceivePort();
    mainSendPort.send(port.sendPort);

    await for (final message in port) {
      final List<int> bytes = message[0];
      final SendPort replyPort = message[1];

      int imageLength = bytes.length;
      List<int> newByte = bytes;

      if (imageLength > 1000000) {
        final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
        int compressQuality = 100;
        int length = imageLength;
        do {
          compressQuality -= 10;
          newByte = img.encodeJpg(
            image,
            quality: compressQuality,
          );
          length = newByte.length;
        } while (length > 1000000);
      }

      replyPort.send(newByte);
    }
  }
}
