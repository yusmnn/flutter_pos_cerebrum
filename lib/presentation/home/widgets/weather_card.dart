import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/format_date.dart';

class WeatherCard extends StatelessWidget {
  final String date;
  final double temperature;
  final String weatherDesc;
  final String image;

  const WeatherCard({
    super.key,
    required this.date,
    required this.temperature,
    required this.weatherDesc,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Container(
        width: 160,
        height: 180,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              FormattedDate.getCurrentDate(date: date),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white70,
                  ),
            ),
            Text(
              FormattedDate.getCurrentTimes(date: date),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white70,
                  ),
            ),
            SvgPicture.network(
              image,
              width: 64,
              height: 64,
              placeholderBuilder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Text(
              weatherDesc,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white70,
                  ),
            ),
            Text(
              '${temperature.toStringAsFixed(1)}°C',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
