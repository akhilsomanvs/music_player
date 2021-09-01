import 'package:flutter/material.dart';
import 'package:music_player/utils/arch_utils/enums/device_screen_type.dart';

import 'responsize_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ScreenTypeLayout({Key? key, this.mobile, this.tablet, this.desktop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
          if (tablet != null) {
            return tablet!;
          }
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
          if (desktop != null) {
            return desktop!;
          }
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
          if (mobile != null) {
            return mobile!;
          }
        }
        return Container();
      },
    );
  }
}
