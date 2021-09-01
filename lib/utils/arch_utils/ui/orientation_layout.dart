import 'package:flutter/material.dart';

class OrientationLayout extends StatelessWidget {
  final Widget? landscape;
  final Widget portrait;

  const OrientationLayout({Key? key, this.landscape, required this.portrait}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var orientation = MediaQuery.of(context).orientation;
        if (orientation == Orientation.landscape) {
          if (landscape != null) {
            return landscape!;
          }
        }
        return portrait;
      },
    );
  }
}
