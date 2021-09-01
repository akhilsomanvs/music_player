import 'package:flutter/material.dart';
import 'package:music_player/utils/arch_utils/utils/ui_utils.dart';

import 'sizing_information.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, SizingInformation sizingInformation) builder;

  const ResponsiveBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        var sizingInformation = SizingInformation(
          deviceScreenType: getDeviceType(mediaQuery),
          screenSize: mediaQuery.size,
          localWidgetSize: Size(constraints.maxWidth, constraints.maxHeight),
        );

        return builder(context, sizingInformation);
      },
    );
  }
}
