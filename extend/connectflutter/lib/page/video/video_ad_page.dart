// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/19
// Description:
// -------------------------------------------------------------------
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interactive_media_ads/interactive_media_ads.dart';
import 'package:video_player/video_player.dart';

class VideoAdPage extends StatefulWidget {
  const VideoAdPage({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoAdPage> with WidgetsBindingObserver {
  static const String _adTagUrl =
      'https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/vmap_ad_samples&sz=640x480&cust_params=sample_ar%3Dpremidpost&ciu_szs=300x250&gdfp_req=1&ad_rule=1&output=vmap&unviewed_position_start=1&env=vp&impl=s&cmsid=496&vid=short_onecue&correlator=';

  late final AdsLoader _adsLoader;
  AdsManager? _adsManager;
  bool _shouldShowContentVideo = false;
  late final VideoPlayerController _contentVideoController;
  Timer? _contentProgressTimer;
  final ContentProgressProvider _contentProgressProvider =
      ContentProgressProvider();
  AppLifecycleState _lastLifecycleState = AppLifecycleState.resumed;

  late final AdDisplayContainer _adDisplayContainer = AdDisplayContainer(
    onContainerAdded: (AdDisplayContainer container) {
      _adsLoader = AdsLoader(
        container: container,
        onAdsLoaded: (OnAdsLoadedData data) {
          final AdsManager manager = data.manager;
          _adsManager = data.manager;

          manager.setAdsManagerDelegate(
            AdsManagerDelegate(
              onAdEvent: (AdEvent event) {
                debugPrint('OnAdEvent: ${event.type} => ${event.adData}');
                switch (event.type) {
                  case AdEventType.loaded:
                    manager.start();
                  case AdEventType.contentPauseRequested:
                    _pauseContent();
                  case AdEventType.contentResumeRequested:
                    _resumeContent();
                  case AdEventType.allAdsCompleted:
                    manager.destroy();
                    _adsManager = null;
                  case AdEventType.clicked:
                  case AdEventType.complete:
                  case _:
                }
              },
              onAdErrorEvent: (AdErrorEvent event) {
                debugPrint('AdErrorEvent: ${event.error.message}');
                _resumeContent();
              },
            ),
          );

          manager.init(settings: AdsRenderingSettings(enablePreloading: true));
        },
        onAdsLoadError: (AdsLoadErrorData data) {
          debugPrint('OnAdsLoadError: ${data.error.message}');
          _resumeContent();
        },
      );

      // Ads can't be requested until the `AdDisplayContainer` has been added to
      // the native View hierarchy.
      _requestAds(container);
    },
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _contentVideoController =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://storage.googleapis.com/gvabox/media/samples/stock.mp4',
            ),
          )
          ..addListener(() {
            if (_contentVideoController.value.isCompleted) {
              _adsLoader.contentComplete();
            }
            setState(() {});
          })
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child:
              !_contentVideoController.value.isInitialized
                  ? Container()
                  : AspectRatio(
                    aspectRatio: _contentVideoController.value.aspectRatio,
                    child: Stack(
                      children: <Widget>[
                        // The display container must be on screen before any Ads can be
                        // loaded and can't be removed between ads. This handles clicks for
                        // ads.
                        _adDisplayContainer,
                        if (_shouldShowContentVideo)
                          VideoPlayer(_contentVideoController),
                      ],
                    ),
                  ),
        ),
      ),
      floatingActionButton:
          _contentVideoController.value.isInitialized && _shouldShowContentVideo
              ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _contentVideoController.value.isPlaying
                        ? _contentVideoController.pause()
                        : _contentVideoController.play();
                  });
                },
                child: Icon(
                  _contentVideoController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
              )
              : null,
    );
  }

  @override
  void didchangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!_shouldShowContentVideo) {
          _adsManager?.resume();
        }
      case AppLifecycleState.inactive:
        if (!_shouldShowContentVideo &&
            _lastLifecycleState == AppLifecycleState.resumed) {
          _adsManager?.pause();
        }
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
    }
    _lastLifecycleState = state;
  }

  Future<void> _requestAds(AdDisplayContainer container) {
    return _adsLoader.requestAds(
      AdsRequest(
        adTagUrl: _adTagUrl,
        contentProgressProvider: _contentProgressProvider,
      ),
    );
  }

  Future<void> _resumeContent() async {
    setState(() {
      _shouldShowContentVideo = true;
    });

    if (_adsManager != null) {
      _contentProgressTimer = Timer.periodic(
        const Duration(milliseconds: 200),
        (Timer timer) async {
          if (_contentVideoController.value.isInitialized) {
            final Duration? progress = await _contentVideoController.position;
            if (progress != null) {
              await _contentProgressProvider.setProgress(
                progress: progress,
                duration: _contentVideoController.value.duration,
              );
            }
          }
        },
      );
    }

    await _contentVideoController.play();
  }

  Future<void> _pauseContent() {
    setState(() {
      _shouldShowContentVideo = false;
    });
    _contentProgressTimer?.cancel();
    _contentProgressTimer = null;
    return _contentVideoController.pause();
  }

  @override
  void dispose() {
    super.dispose();
    _contentProgressTimer?.cancel();
    _contentVideoController.dispose();
    _adsManager?.destroy();
    WidgetsBinding.instance.removeObserver(this);
  }
}
