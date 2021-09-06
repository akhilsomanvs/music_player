import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/utils/appUtils/app_theme.dart';
import 'package:music_player/utils/commonUtils/app_assets.dart';
import 'package:music_player/utils/commonUtils/size_config.dart';
import 'package:music_player/utils/widgets/spacing_widgets.dart';

class PlayerWidget extends StatefulWidget {
  final String songName;
  final String albumName;

  final Function(bool)? onPlayButtonTap;
  final Function? onPrevButtonTap;
  final Function? onNextButtonTap;

  PlayerWidget({Key? key, required this.songName, this.albumName = "", this.onPlayButtonTap, this.onPrevButtonTap, this.onNextButtonTap}) : super(key: key);

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> with TickerProviderStateMixin {
  PlayerController controller = Get.find();

  //Record rotation Animation
  late AnimationController rotationController;
  late Animation rotationAnimation;

  //Record Scale Animation
  late AnimationController scaleAnimController;
  late Animation scaleAnimation;

  //Slide Up Animation
  late AnimationController slideUpAnimController;
  late Animation slideUpAnimation;

  //Progress Indicator
  late AnimationController progressAnimController;
  late Animation progressAnimation;

  @override
  void initState() {
    rotationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    rotationAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(rotationController);
    rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotationController.reset();
        rotationController.forward();
      }
    });

    scaleAnimController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    scaleAnimation = Tween<double>(begin: 0.9, end: 1.2).animate(scaleAnimController);

    slideUpAnimController = AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    slideUpAnimation = Tween<Offset>(begin: Offset(0, 100), end: Offset(0, 0)).animate(slideUpAnimController);

    progressAnimController = AnimationController(vsync: this, duration: Duration(minutes: 1, seconds: 30));
    progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(progressAnimController);
    progressAnimController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        progressAnimController.reset();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double bottomPadding = SizeConfig.getBottomScreenPadding(); // + SizeConfig.getVerticalSize(12);
    return Container(
      child: Stack(
        children: [
          ///
          ///Music Details Container
          ///
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.getVerticalSize(0),
                horizontal: SizeConfig.getHorizontalSize(16),
              ),
              child: AnimatedBuilder(
                animation: slideUpAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: slideUpAnimation.value,
                    child: child,
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: SizeConfig.getVerticalSize(110),
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.getVerticalSize(12),
                    horizontal: SizeConfig.getHorizontalSize(12),
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.appColors.pageBackground.withOpacity(1.0),
                    // color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(SizeConfig.getVerticalSize(12)),
                      topLeft: Radius.circular(SizeConfig.getVerticalSize(12)),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: Offset(0, -5),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 4, child: Container()),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Flume',
                              style: TextStyle(fontSize: SizeConfig.getTextSize(16), fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Say It',
                              style: TextStyle(fontSize: SizeConfig.getTextSize(12), color: AppTheme.appColors.greyTextColor),
                            ),
                            Expanded(flex: 1, child: Container()),
                            AnimatedBuilder(
                              animation: progressAnimation,
                              builder: (context, child) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    color: AppTheme.appColors.appProgressIndicatorColor,
                                    backgroundColor: AppTheme.appColors.appPrimaryColorWhite,
                                    value: progressAnimation.value,
                                  ),
                                );
                              },
                            ),
                            Expanded(flex: 2, child: Container()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          ///
          ///Player Icons Holder
          ///
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.getVerticalSize(80)),
            child: Container(
              // height: SizeConfig.getVerticalSize(100),
              padding: EdgeInsets.only(
                left: SizeConfig.getHorizontalSize(12),
                right: SizeConfig.getHorizontalSize(12),
                top: SizeConfig.getVerticalSize(12),
                bottom: bottomPadding,
              ),
              decoration: BoxDecoration(
                color: AppTheme.appColors.appPrimaryColorWhite,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(SizeConfig.getVerticalSize(12)),
                  topLeft: Radius.circular(SizeConfig.getVerticalSize(12)),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    offset: Offset(0, -5),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(flex: 4, child: Container()),
                  Flexible(
                    flex: 2,
                    child: PlayerIcon(
                      icon: Icons.skip_previous,
                      onTap: (isActive) {
                        if (widget.onPrevButtonTap != null) {
                          widget.onPrevButtonTap!();
                        }
                      },
                    ),
                  ),
                  HSpace(8),
                  Flexible(
                    flex: 2,
                    child: PlayerIcon(
                      icon: Icons.play_arrow,
                      activeIcon: Icons.pause,
                      canBeActive: true,
                      isActive: controller.isPlaying.value,
                      onTap: (isActive) {
                        controller.setIsPlaying(isActive);
                        triggerRecordAnimation(isActive);
                        if (widget.onPlayButtonTap != null) {
                          widget.onPlayButtonTap!(isActive);
                        }
                      },
                    ),
                  ),
                  HSpace(8),
                  Flexible(
                    flex: 2,
                    child: PlayerIcon(
                      icon: Icons.skip_next,
                      onTap: (isActive) {
                        if (widget.onNextButtonTap != null) {
                          widget.onNextButtonTap!();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///
          ///Record Holder
          ///
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 4,
                    child: AnimatedBuilder(
                      animation: scaleAnimation,
                      child: AnimatedBuilder(
                        animation: this.rotationAnimation,
                        child: Container(
                          width: SizeConfig.getVerticalSize(110),
                          height: SizeConfig.getVerticalSize(110),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                            image: DecorationImage(image: AssetImage(AppAssets.getImagePath("album_placeholder.png")), fit: BoxFit.contain),
                          ),
                          child: Center(
                            child: Container(
                              width: SizeConfig.getVerticalSize(24),
                              height: SizeConfig.getVerticalSize(24),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(300), color: Colors.white),
                            ),
                          ),
                        ),
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: this.rotationAnimation.value,
                            alignment: Alignment.center,
                            child: child,
                          );
                        },
                      ),
                      builder: (context, child) {
                        return Transform.scale(
                          scale: scaleAnimation.value,
                          alignment: Alignment.bottomCenter,
                          child: child,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void triggerRecordAnimation(bool isActive) {
    if (isActive) {
      rotationController.forward();
      scaleAnimController.forward();
      progressAnimController.forward();
      slideUpAnimController.forward();
    } else {
      progressAnimController.stop(canceled: false);
      slideUpAnimController.reverse();
      scaleAnimController.reverse().then((value) {
        rotationController.stop(canceled: false);
      });
    }
  }
}

class PlayerIcon extends StatefulWidget {
  final IconData icon;
  final IconData? activeIcon;
  final bool isActive;
  final bool canBeActive;
  final Function(bool)? onTap;

  PlayerIcon({
    Key? key,
    required this.icon,
    this.activeIcon,
    this.isActive = false,
    this.canBeActive = false,
    this.onTap,
  }) : super(key: key);

  @override
  _PlayerIconState createState() => _PlayerIconState();
}

class _PlayerIconState extends State<PlayerIcon> {
  bool isPressed = false;

  @override
  void initState() {
    this.isPressed = widget.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (details) {
        debugPrint("TAP :::::: ");
        setState(() {
          this.isPressed = !this.isPressed;
        });

        if (widget.onTap != null) {
          widget.onTap!(this.isPressed);
        }
      },
      onTapUp: (details) {
        debugPrint("TAP UP :::::: ");
        if (!widget.canBeActive) {
          setState(() {
            this.isPressed = !this.isPressed;
          });
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: this.isPressed ? AppTheme.appColors.appGrey : AppTheme.appColors.appPrimaryColorWhite,
            borderRadius: BorderRadius.circular(SizeConfig.getVerticalSize(12)),
          ),
          child: Icon(
            widget.activeIcon == null ? widget.icon : (this.isPressed ? widget.activeIcon : widget.icon),
            color: this.isPressed ? AppTheme.appColors.appPrimaryColorWhite : AppTheme.appColors.appGrey,
          ),
        ),
      ),
    );
  }
}
