import 'dart:io';

abstract class AudioSessionState {}

class AudioSessionIdle extends AudioSessionState {}

class AudioSessionRecording extends AudioSessionState {}

class AudioSessionProcessing extends AudioSessionState {}

class AudioSessionPlaying extends AudioSessionState {
  File? responseAudio;

  AudioSessionPlaying({
    this.responseAudio
  });
}

class AudioSessionError extends AudioSessionState {
  String? message;
  bool? canRetry;

  AudioSessionError({
    this.message,
    this.canRetry,
  });
}