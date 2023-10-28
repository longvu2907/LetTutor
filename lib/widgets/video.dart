import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final String url;
  final double height;

  const Video({
    super.key,
    required this.url,
    required this.height,
  });

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;
  bool _isScrubbing = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.url,
      ),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      InkWell(
        onTap: _playVideo,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black54,
          ),
          child: Column(
            children: [
              SizedBox(
                height: widget.height,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              SizedBox(
                height: _isScrubbing ? 20 : 10,
                child: Listener(
                  onPointerDown: (e) {
                    setState(() {
                      _isScrubbing = true;
                    });
                  },
                  onPointerUp: (e) {
                    setState(() {
                      _isScrubbing = false;
                    });
                  },
                  child: VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: Theme.of(context).colorScheme.primary,
                      bufferedColor: Colors.white.withOpacity(0.5),
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    _controller.value.isPlaying
                        ? const Icon(
                            Icons.pause,
                            color: Colors.white,
                            size: 24,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 24,
                          ),
                    Text(
                      '  ${_videoDuration(_controller.value.position)} / ${_videoDuration(_controller.value.duration)}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Positioned.fill(
        child: Center(
          child: _controller.value.isPlaying
              ? Container()
              : GestureDetector(
                  onTap: _playVideo,
                  child: Icon(
                    Icons.play_arrow,
                    color: Theme.of(context).colorScheme.primary,
                    size: 50,
                  ),
                ),
        ),
      )
    ]);
  }

  void _playVideo() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
