
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer;

  AudioPlayerService({
    AudioPlayer? audioPlayer,
}) :  _audioPlayer = audioPlayer ?? AudioPlayer();

  Future<void> play(File audioFile) async {
    await _audioPlayer.play(DeviceFileSource(audioFile.path));
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }

}