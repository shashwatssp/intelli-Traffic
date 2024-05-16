import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart';

class PlayVideoPage extends StatefulWidget {
  final String videoFileName;

  const PlayVideoPage({Key? key, required this.videoFileName})
      : super(key: key);

  @override
  _PlayVideoPageState createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {
  late VideoPlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    try {
      // Get the download URL of the video
      String videoUrl = await _getVideoDownloadUrl();

      // Initialize the video player controller
      _controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          setState(() {
            _isLoading = false;
            _controller.play();
          });
        });

      // Add listener to detect when video playback completes
      _controller.addListener(() {
        if (_controller.value.position == _controller.value.duration) {
          _controller.seekTo(Duration.zero); // Seek video to beginning
          _controller.play(); // Play video again
        }
      });
    } catch (error) {
      // Handle error if video download fails
      print('Error: $error');
    }
  }

  Future<String> _getVideoDownloadUrl() async {
    // Create a reference to the video file
    Reference videoRef =
        FirebaseStorage.instance.ref().child('videos/TRAFFIC.mp4');

    // Get the download URL
    String downloadUrl = await videoRef.getDownloadURL();

    return downloadUrl;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Footage'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.videoFileName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Adjust the size as needed
          const SizedBox(
            height: 15,
          ),
          Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : const Text('Loading ...'),
          ),
        ],
      ),
    );
  }
}
