import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/theme/colors.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animation/empty.json',
            width: 200,
            height: 200,
          ),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.darkBlue,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
