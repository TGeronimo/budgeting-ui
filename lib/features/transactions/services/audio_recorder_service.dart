import 'package:record/record.dart';

class AudioRecorderService {
  final AudioRecorder _audioRecorder;

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

  Future<void> startRecording({required String path}) async {
    await _audioRecorder.start(RecordConfig(encoder: AudioEncoder.wav), path: path);
  }

  Future<String?> stopRecording() async {
    return await _audioRecorder.stop();
  }

  void dispose() {
    _audioRecorder.dispose();
  }
}