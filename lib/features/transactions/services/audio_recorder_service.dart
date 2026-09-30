import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioRecorderService {
  final AudioRecorder _audioRecorder;
  late final Directory tempDirectory;
  late final audioPath;

  AudioRecorderService({
    AudioRecorder? audioRecorder,
  })  : _audioRecorder = audioRecorder ?? AudioRecorder();

  Future<void> start(String audioPath) async {
    await _audioRecorder.start(
      RecordConfig(encoder: AudioEncoder.wav),
      path: audioPath,
    );
  }

  Future<bool> hasMicPermission() async {
    return await _audioRecorder.hasPermission();
  }

  Future<void> startRecording() async {
    if(kIsWeb) {

      await _audioRecorder.start(
          RecordConfig(encoder: AudioEncoder.wav),
          path: ''
      );

    } else {

      tempDirectory = await getTemporaryDirectory();
      audioPath = '${tempDirectory.path}/transaction.wav';

      await _audioRecorder.start(
          RecordConfig(encoder: AudioEncoder.wav),
          path: audioPath
      );
      debugPrint('Gravação iniciada no caminho: $audioPath');
    }
  }

  Future<String?> stopRecording() async {
    return await _audioRecorder.stop();
  }

  void dispose() {
    _audioRecorder.dispose();
  }
}