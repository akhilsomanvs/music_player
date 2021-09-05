import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/utils/appUtils/app_theme.dart';
import 'package:music_player/utils/arch_utils/ui/responsize_builder.dart';
import 'package:music_player/utils/commonUtils/app_assets.dart';
import 'package:music_player/utils/commonUtils/size_config.dart';
import 'package:music_player/utils/widgets/spacing_widgets.dart';
import 'package:music_player/views/widgets/player_widget.dart';

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
                  PlayerWidget(
                    songName: 'Flume',
                    albumName: 'Say It',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
