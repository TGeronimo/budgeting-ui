import 'dart:io';

abstract class AudioSessionState {}

class AudioSessionIdle extends AudioSessionState {}

class AudioSessionRecording extends AudioSessionState {}

class AudioSessionProcessing extends AudioSessionState {}

class AudioSessionPlaying extends AudioSessionState {
  final File responseAudio;

  AudioSessionPlaying({
    required this.responseAudio
  });
}

class AudioSessionError extends AudioSessionState {
  final String message;
  final bool canRetry;

  AudioSessionError({
    required this.message,
    this.canRetry = true,
  });
}