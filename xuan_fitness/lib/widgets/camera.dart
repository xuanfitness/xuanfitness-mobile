import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class Camera extends StatefulWidget {
  Camera({Key key, this.title, this.image, this.video}) : super(key: key);

  final String title;
  final bool image, video;

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  PickedFile _imageFile, _pickedFile;
  dynamic _pickImageError;
  bool isVideo = false;
  VideoPlayerController _controller;
  VideoPlayerController _toBeDisposed;
  String _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  Future<void> _playVideo(PickedFile file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      if (kIsWeb) {
        _controller = VideoPlayerController.network(file.path);
        // In web, most browsers won't honor a programmatic call to .play
        // if the video has a sound track (and is not muted).
        // Mute the video so it auto-plays in web!
        // This is not needed if the call to .play is the result of user
        // interaction (clicking on a "play" button, for example).
        await _controller.setVolume(0.0);
      } else {
        _controller = VideoPlayerController.file(File(file.path));
        await _controller.setVolume(1.0);
      }
      await _controller.initialize();
      await _controller.setLooping(true);
      await _controller.play();
      setState(() {});
    }
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    if (_controller != null) {
      await _controller.setVolume(0.0);
    }
    if (isVideo) {
      final PickedFile file = await _picker.getVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      setState(() {
        _pickedFile = file;
      });
      await _playVideo(file);
    } else {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
        );
        setState(() {
          _pickedFile = pickedFile;
          _imageFile = pickedFile;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Widget _previewVideo() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      if (kIsWeb) {
        // Why network?
        // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
        return Image.network(_imageFile.path);
      } else {
        return Semantics(
            child: Image.file(File(_imageFile.path)),
            label: 'image_picker_example_picked_image');
      }
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
        });
      }
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  List<Widget> renderButtons() {
    List<Widget> buttons = List<Widget>();
    if (widget.image) {
      buttons.add(Semantics(
        label: 'image_picker_example_from_gallery',
        child: FloatingActionButton(
          onPressed: () {
            isVideo = false;
            _onImageButtonPressed(ImageSource.gallery, context: context);
          },
          heroTag: 'image0',
          tooltip: 'Pick Image from gallery',
          child: const Icon(Icons.photo_library),
        ),
      ));
      buttons.add(
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: FloatingActionButton(
            onPressed: () {
              isVideo = false;
              _onImageButtonPressed(ImageSource.camera, context: context);
            },
            heroTag: 'image1',
            tooltip: 'Take a Photo',
            child: const Icon(Icons.camera_alt),
          ),
        ),
      );
    }
    if (widget.video) {
      buttons.add(
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              isVideo = true;
              _onImageButtonPressed(ImageSource.gallery);
            },
            heroTag: 'video0',
            tooltip: 'Pick Video from gallery',
            child: const Icon(Icons.video_library),
          ),
        ),
      );
      buttons.add(
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              isVideo = true;
              _onImageButtonPressed(ImageSource.camera);
            },
            heroTag: 'video1',
            tooltip: 'Take a Video',
            child: const Icon(Icons.videocam),
          ),
        ),
      );
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(null),
          ),
          actions: [
            IconButton(
              icon: new Icon(Icons.check),
              onPressed: () => Navigator.of(context).pop(_pickedFile),
            ),
            IconButton(
              icon: new Icon(Icons.delete),
              onPressed: () => Navigator.of(context).pop(null),
            ),
          ],
        ),
        body: Center(
          child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
              ? FutureBuilder<void>(
                  future: retrieveLostData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Text(
                          'You have not yet picked an image.',
                          textAlign: TextAlign.center,
                        );
                      case ConnectionState.done:
                        return isVideo ? _previewVideo() : _previewImage();
                      default:
                        if (snapshot.hasError) {
                          return Text(
                            'Pick image/video error: ${snapshot.error}}',
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return const Text(
                            'You have not yet picked an image.',
                            textAlign: TextAlign.center,
                          );
                        }
                    }
                  },
                )
              : (isVideo ? _previewVideo() : _previewImage()),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: renderButtons(),
          // <Widget>[
          //   Semantics(
          //     label: 'image_picker_example_from_gallery',
          //     child: FloatingActionButton(
          //       onPressed: () {
          //         isVideo = false;
          //         _onImageButtonPressed(ImageSource.gallery, context: context);
          //       },
          //       heroTag: 'image0',
          //       tooltip: 'Pick Image from gallery',
          //       child: const Icon(Icons.photo_library),
          //     ),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.only(top: 16.0),
          //     child: FloatingActionButton(
          //       onPressed: () {
          //         isVideo = false;
          //         _onImageButtonPressed(ImageSource.camera, context: context);
          //       },
          //       heroTag: 'image1',
          //       tooltip: 'Take a Photo',
          //       child: const Icon(Icons.camera_alt),
          //     ),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.only(top: 16.0),
          //     child: FloatingActionButton(
          //       backgroundColor: Colors.red,
          //       onPressed: () {
          //         isVideo = true;
          //         _onImageButtonPressed(ImageSource.gallery);
          //       },
          //       heroTag: 'video0',
          //       tooltip: 'Pick Video from gallery',
          //       child: const Icon(Icons.video_library),
          //     ),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.only(top: 16.0),
          //     child: FloatingActionButton(
          //       backgroundColor: Colors.red,
          //       onPressed: () {
          //         isVideo = true;
          //         _onImageButtonPressed(ImageSource.camera);
          //       },
          //       heroTag: 'video1',
          //       tooltip: 'Take a Video',
          //       child: const Icon(Icons.videocam),
          //     ),
          //   ),
          // ],
        ),
      ),
    );
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller.value.isInitialized) {
      initialized = controller.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value?.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
    } else {
      return Container();
    }
  }
}
