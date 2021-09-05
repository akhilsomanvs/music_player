import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/utils/appUtils/app_theme.dart';
import 'package:music_player/utils/arch_utils/ui/responsize_builder.dart';
import 'package:music_player/utils/commonUtils/app_assets.dart';
import 'package:music_player/utils/commonUtils/size_config.dart';
import 'package:music_player/utils/widgets/spacing_widgets.dart';

class MusicListScreen extends StatelessWidget {
  double _containerHeight = 0;

  MusicListScreen({Key? key}) : super(key: key);

  // PlayerController controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appColors.pageBackground,
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (_containerHeight < sizingInformation.localWidgetSize.height) {
            _containerHeight = sizingInformation.localWidgetSize.height;
          }
          return SingleChildScrollView(
            child: Container(
              height: _containerHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Container()),
                  PlayerWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PlayerWidget extends StatefulWidget {
  final Function(bool)? onPlayButtonTap;
  final Function? onPrevButtonTap;
  final Function? onNextButtonTap;

  PlayerWidget({Key? key, this.onPlayButtonTap, this.onPrevButtonTap, this.onNextButtonTap}) : super(key: key);

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> with TickerProviderStateMixin {
  PlayerController controller = Get.find();

  //Record rotation
  late AnimationController rotationController;
  late Animation rotationAnimation;

  //Record Scale
  late AnimationController scaleAnimController;
  late Animation scaleAnimation;

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
    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(scaleAnimController);
    /*scaleAnimController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        scaleAnimController.reset();
        scaleAnimController.forward();
      }
    });*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double bottomPadding = SizeConfig.getVerticalSize(12) + SizeConfig.getVerticalSize(12);
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.getVerticalSize(120)),
            child: Container(
              height: SizeConfig.getVerticalSize(100),
              padding: EdgeInsets.only(left: SizeConfig.getHorizontalSize(12), right: SizeConfig.getHorizontalSize(12), top: SizeConfig.getVerticalSize(12), bottom: bottomPadding),
              decoration: BoxDecoration(
                color: AppTheme.appColors.appPrimaryColorWhite,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(SizeConfig.getVerticalSize(12)),
                  topLeft: Radius.circular(SizeConfig.getVerticalSize(12)),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: Offset(0, -10),
                    blurRadius: 15,
                    spreadRadius: 2,
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
                      canBeActive: true,
                      isActive: controller.isPlaying.value,
                      onTap: (isActive) {
                        controller.setIsPlaying(isActive);
                        if (isActive) {
                          rotationController.forward();
                          scaleAnimController.forward();
                        } else {
                          scaleAnimController.reverse().then((value) {
                            rotationController.stop(canceled: false);
                          });
                        }
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
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 5,
                    child: AnimatedBuilder(
                      animation: scaleAnimation,
                      child: AnimatedBuilder(
                        animation: this.rotationAnimation,
                        child: Container(
                          width: SizeConfig.getVerticalSize(120),
                          height: SizeConfig.getVerticalSize(120),
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
                    flex: 6,
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
}

class PlayerIcon extends StatefulWidget {
  final IconData icon;
  final bool isActive;
  final bool canBeActive;
  final Function(bool)? onTap;

  PlayerIcon({
    Key? key,
    required this.icon,
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
            widget.icon,
            color: this.isPressed ? AppTheme.appColors.appPrimaryColorWhite : AppTheme.appColors.appGrey,
          ),
        ),
      ),
    );
  }
}
