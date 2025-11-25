import 'package:flutter/cupertino.dart';
import 'package:sparktech_agency_task/core/constants/colors.dart';

class Loader extends StatelessWidget {
  final Color? color;
  final double? radius;

  const Loader({super.key, this.color, this.radius});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: radius ?? 16,
        color: color ?? AppColors.white,
      ),
    );
  }
}
