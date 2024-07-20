import 'package:fitness_ui/custom_widget/custombutton.dart';
import 'package:fitness_ui/home/home_page.dart';
import 'package:fitness_ui/light_dark_constant.dart';
import 'package:fitness_ui/model/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../generated/l10n.dart';

class StartTrainingScreen extends StatefulWidget {
  const StartTrainingScreen({super.key, required this.url, required this.name, required this.time, required this.relatedList});

  final String url;
  final String name;
  final String time;
  final List<RelateModel> relatedList;

  @override
  State<StartTrainingScreen> createState() => _StartTrainingScreenState();
}

class _StartTrainingScreenState extends State<StartTrainingScreen> {
  final RxBool isPlay = false.obs;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countDown); // Create instance.

  @override
  void initState() {
    _stopWatchTimer.setPresetMinuteTime(int.parse(widget.time), add: false);
    super.initState();
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Back(),
        title: Text(widget.name, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VideoPlay(url: widget.url),
            SizedBox(height: 30.h),
            Text('${widget.time} ${S.of(context).min}', style: TextStyle(fontSize: 20.sp, fontFamily: 'SB')),
            SizedBox(height: 8.h),
            Text(S.of(context).exercise_Time, style: TextStyle(fontSize: 13.sp, fontFamily: 'M')),
            SizedBox(height: 20.h),
            if (int.parse(widget.time) > 0) ...[
              StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const SizedBox.shrink();
                    }
                    final int minute = StopWatchTimer.getMinute(snapshot.data!);
                    final int second = int.parse(StopWatchTimer.getDisplayTimeSecond(snapshot.data!));
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 100.w,
                          width: 100.w,
                          child: CircularProgressIndicator(backgroundColor: greyColor, color: greenColor, value: minute.toDouble() / int.parse(widget.time), strokeWidth: 10.w),
                        ),
                        Text("${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}", style: TextStyle(fontSize: 13.sp, fontFamily: 'SB')),
                      ],
                    );
                  }),
              SizedBox(height: 20.h),
              Obx(() {
                isPlay.value;
                return OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(100.w, 50.h),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    side: BorderSide(width: 1.w, color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    if (isPlay.value) {
                      isPlay.value = false;
                      _stopWatchTimer.onStopTimer();
                    } else {
                      isPlay.value = true;
                      _stopWatchTimer.onStartTimer();
                    }
                  },
                  icon: Icon(isPlay.value ? Icons.pause : Icons.play_arrow, color: Theme.of(context).primaryColor),
                  label: Text(isPlay.value ? S.of(context).Stop : S.of(context).start, style: TextStyle(fontSize: 15.sp, fontFamily: "SB")),
                );
              }),
            ],
            if (widget.relatedList.isNotEmpty)
              AnimationLimiter(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                  itemCount: widget.relatedList.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        duration: const Duration(milliseconds: 375),
                        horizontalOffset: 50,
                        child: FadeInAnimation(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Imageview(image: widget.relatedList[index].img, height: 91.h, width: 91.h, radius: 10.r),
                              SizedBox(width: 15.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.relatedList[index].title, maxLines: 2, style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
                                  SizedBox(height: 13.h),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset('assets/icons/calories.svg', height: 15.h, width: 15.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                        SizedBox(width: 3.h),
                                        Text('${widget.relatedList[index].kcal} ${S.of(context).kcal}', style: TextStyle(fontSize: 12.sp, fontFamily: 'M')),
                                        SizedBox(height: 10.h, child: const VerticalDivider(color: Colors.grey, thickness: 2)),
                                        SvgPicture.asset('assets/icons/clock.svg', height: 12.h, width: 12.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                        SizedBox(width: 3.h),
                                        Text('${widget.relatedList[index].time} ${S.of(context).min}', style: TextStyle(fontSize: 12.sp, fontFamily: 'M'))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 9.h),
                                  Text(widget.relatedList[index].exerciseType, style: TextStyle(fontSize: 13.sp, fontFamily: 'M')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1, height: 28.h, endIndent: 10, indent: 10, color: Theme.of(context).primaryColor),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class VideoPlay extends StatefulWidget {
  const VideoPlay({super.key, required this.url});

  final String url;

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  VideoPlayerController? _controller;
  late YoutubePlayerController youtubePlayerController;

  int _currentPosition = 0;
  int _duration = 0;
  bool isBuffering = false;
  bool showOverLay = false;
  bool muted = false;

  @override
  void initState() {
    if (widget.url.contains('https://youtu.be')) {
      String videoId;
      videoId = YoutubePlayer.convertUrlToId(widget.url)!;
      youtubePlayerController = YoutubePlayerController(initialVideoId: videoId, flags: const YoutubePlayerFlags(autoPlay: false, mute: true, hideControls: true));
      youtubeListenerToController();
    } else {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
        ..initialize().then((_) {
          setState(() {});
        });
      _attachListenerToController();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  youtubeListenerToController() {
    youtubePlayerController.addListener(
      () {
        if (mounted) {
          setState(() {
            _currentPosition = youtubePlayerController.value.metaData.duration.inMilliseconds == 0 ? 0 : youtubePlayerController.value.position.inMilliseconds;
            _duration = youtubePlayerController.value.metaData.duration.inMilliseconds;
          });
        }
      },
    );
  }

  _attachListenerToController() {
    _controller!.addListener(
      () {
        isBuffering = _controller!.value.isBuffering;
        if (mounted) {
          setState(() {
            _currentPosition = _controller!.value.duration.inMilliseconds == 0 ? 0 : _controller!.value.position.inMilliseconds;
            _duration = _controller!.value.duration.inMilliseconds;
          });
        }
      },
    );
  }

  String durationFormatter(int milliSeconds) {
    int seconds = milliSeconds ~/ 1000;
    final int hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    var minutes = seconds ~/ 60;
    seconds = seconds % 60;
    final hoursString = hours >= 10
        ? '$hours'
        : hours == 0
            ? '00'
            : '0$hours';
    final minutesString = minutes >= 10
        ? '$minutes'
        : minutes == 0
            ? '00'
            : '0$minutes';
    final secondsString = seconds >= 10
        ? '$seconds'
        : seconds == 0
            ? '00'
            : '0$seconds';
    final formattedTime = '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url.contains('https://youtu.be') == true) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            YoutubePlayer(controller: youtubePlayerController),
            GestureDetector(
              onTap: () {
                setState(() {
                  showOverLay = !showOverLay;
                });
              },
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 50),
              reverseDuration: const Duration(milliseconds: 200),
              child: showOverLay
                  ? Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                muted ? Icons.volume_off : Icons.volume_up,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (muted) {
                                    youtubePlayerController.unMute();
                                  } else {
                                    youtubePlayerController.mute();
                                  }
                                  muted = !muted;
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 10.w),
                                Text(durationFormatter(_currentPosition), style: TextStyle(fontSize: 13.sp, fontFamily: 'M', color: Colors.white)),
                                SizedBox(width: 10.w),
                                ProgressBar(isExpanded: true, controller: youtubePlayerController),
                                SizedBox(width: 10.w),
                                Text(durationFormatter(_duration), style: TextStyle(fontSize: 13.sp, fontFamily: 'M', color: Colors.white)),
                                SizedBox(width: 10.w),
                              ],
                            ),
                          ],
                        ),
                        Center(
                          child: RawMaterialButton(
                            padding: EdgeInsets.all(10.r),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            fillColor: Colors.black.withOpacity(0.5),
                            shape: const CircleBorder(),
                            child: Icon(
                              youtubePlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                youtubePlayerController.value.isPlaying ? youtubePlayerController.pause() : youtubePlayerController.play();
                                showOverLay = youtubePlayerController.value.isPlaying ? false : true;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: _controller != null ? _controller!.value.aspectRatio : 16 / 9,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            VideoPlayer(_controller!),
            GestureDetector(
              onTap: () {
                setState(() {
                  showOverLay = !showOverLay;
                });
              },
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 50),
              reverseDuration: const Duration(milliseconds: 200),
              child: showOverLay
                  ? Stack(alignment: Alignment.bottomLeft, children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Visibility(
                            visible: !isBuffering,
                            child: IconButton(
                              icon: Icon(
                                muted ? Icons.volume_off : Icons.volume_up,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_controller!.value.volume == 0) {
                                    _controller!.setVolume(1.0);
                                  } else {
                                    _controller!.setVolume(0.0);
                                  }
                                  muted = !muted;
                                });
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 10.w),
                              Text(durationFormatter(_currentPosition), style: TextStyle(fontSize: 13.sp, fontFamily: 'M', color: Colors.white)),
                              SizedBox(width: 10.w),
                              Expanded(
                                  child: VideoProgressIndicator(
                                _controller!,
                                allowScrubbing: true,
                                colors: const VideoProgressColors(playedColor: greenColor, backgroundColor: Colors.white),
                              )),
                              SizedBox(width: 10.w),
                              Text(durationFormatter(_duration), style: TextStyle(fontSize: 13.sp, fontFamily: 'M', color: Colors.white)),
                              SizedBox(width: 10.w),
                            ],
                          ),
                        ],
                      ),
                      Center(
                        child: RawMaterialButton(
                          padding: EdgeInsets.all(10.r),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          fillColor: Colors.black.withOpacity(0.5),
                          shape: const CircleBorder(),
                          child: Icon(
                            _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
                              showOverLay = _controller!.value.isPlaying ? false : true;
                            });
                          },
                        ),
                      ),
                    ])
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    }
  }
}
