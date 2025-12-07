import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoProvider with ChangeNotifier {
  late VideoPlayerController _gopalController;
  bool _isInitialized = false;

  VideoPlayerController get gopalController => _gopalController;
  bool get isInitialized => _isInitialized;
  bool get isPlaying => _isInitialized && _gopalController.value.isPlaying;

  VideoProvider() {
    _initGopalVideo();
  }

  Future<void> _initGopalVideo() async {
    _gopalController = VideoPlayerController.network(
      "https://www.dropbox.com/scl/fi/m5n41ln9nrcc9o94sh0rt/WhatsApp-Video-2025-12-07-at-2.33.21-PM.mp4?rlkey=jr7c98f6nk5inqq541oe7kxdg&st=471rbt31&raw=1",
    );

    await _gopalController.initialize();
    _gopalController.setLooping(true);

    _isInitialized = true;
    notifyListeners();
  }

  void togglePlayPause() {
    if (!_isInitialized) return;

    if (_gopalController.value.isPlaying) {
      _gopalController.pause();
    } else {
      _gopalController.play();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _gopalController.dispose();
    }
    super.dispose();
  }
}
