import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../providers/single_movie_provider.dart';
import 'package:http/http.dart' as http;
//
class VideoPoster extends StatefulWidget {
  Movie loadedMovie;
  VideoPoster({Key? key, required this.loadedMovie}) : super(key: key);

  @override
  State<VideoPoster> createState() => _VideoPosterState();
}

class _VideoPosterState extends State<VideoPoster> {
  YoutubePlayerController _controller =
      YoutubePlayerController(initialVideoId: '');
  late bool _isLoading;
  late bool _isNull;
  late bool _isMuted = true;
  String videoURL = '';

  Future<void> setVideo(filmId) async {
    final url = '$apiLink/search/video?id=$filmId';

    try {
      setState(() {
        _isLoading = true;
        _isNull = false;
      });
      var response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

      String source = Utf8Decoder().convert(response.bodyBytes);

      final extractedData = Map<String, dynamic>.from(json.decode(source));

      String video = await extractedData['video'][0] == null
          ? ''
          : await extractedData['video'][0]['url'];

      YoutubePlayer.convertUrlToId(video) == null
          ? setState(() {
              _isNull = true;
            })
          : _controller = YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(video)!,
              flags: const YoutubePlayerFlags(
                  mute: true,
                  autoPlay: true,
                  disableDragSeek: true,
                  loop: true,
                  isLive: false,
                  forceHD: true,
                  enableCaption: false,
                  hideControls: true,
                  controlsVisibleAtStart: false),
            );

      setState(() {
        _isLoading = false;
      });
    } on Exception catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setVideo(widget.loadedMovie.id);
  }

  @override
  void dispose() {
    if (_controller.hasListeners) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading || _isNull
        ? Container(
            height: MediaQuery.of(context).size.height * 0.50 - 20,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.loadedMovie.poster),
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.50 - 20,
            child: SizedBox.expand(
              child: FittedBox(
                clipBehavior: Clip.hardEdge,
                fit: BoxFit.cover,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (_isMuted) {
                        _controller.unMute();
                        setState(() {
                          _isMuted = false;
                        });
                      } else {
                        _controller.mute();
                        setState(() {
                          _isMuted = true;
                        });
                      }
                    },
                    child: YoutubePlayer(
                      showVideoProgressIndicator: false,
                      controlsTimeOut: Duration(milliseconds: 1),
                      controller: _controller,
                      aspectRatio: 4,
                      progressColors: const ProgressBarColors(
                          bufferedColor: Colors.transparent,
                          playedColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          handleColor: Colors.transparent),
                      progressIndicatorColor: Colors.transparent,
                      width: MediaQuery.of(context).size.height * 3,
                      onReady: () {},
                      thumbnail: Container(
                        color: Color.fromARGB(255, 3, 3, 3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
