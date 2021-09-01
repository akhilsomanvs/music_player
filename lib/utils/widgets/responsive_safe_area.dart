import 'package:flutter/material.dart';

typedef ResponsiveBuilderFunction = Widget Function(
  BuildContext context,
  Size size,
);

class ResponsiveSafeArea extends StatelessWidget {
  const ResponsiveSafeArea({
    required ResponsiveBuilderFunction builder,
    Key? key,
  })  : responsiveBuilder = builder,
        super(key: key);

  final ResponsiveBuilderFunction responsiveBuilder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return responsiveBuilder(
            context,
            constraints.biggest,
          );
        },
      ),
    );
  }
}
