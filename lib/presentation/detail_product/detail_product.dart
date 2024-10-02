import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pos_cerebrum/core/theme/colors.dart';

import '../../core/utils/format_rupiah.dart';

class DetailProductPage extends StatelessWidget {
  static const routeName = '/detail_product';

  final String imagePath;
  final String title;
  final String description;
  final double price;
  final int quantity;

  const DetailProductPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: AppColors.primary),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.file(
              File(imagePath),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: ${FormattedRupiah.formatRupiah(price)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Quantity: $quantity',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
