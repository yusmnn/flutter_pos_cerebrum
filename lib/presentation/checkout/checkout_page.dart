import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pos_cerebrum/presentation/home/home_page.dart';

import '../../core/theme/colors.dart';
import '../../core/utils/format_rupiah.dart';
import '../../core/utils/spaces.dart';
import '../../data/datasources/local/product_local_datasource.dart';
import '../../data/models/request/product.dart';

class CheckoutPage extends StatefulWidget {
  final List<Product> selectedProducts;

  const CheckoutPage({super.key, required this.selectedProducts});

  static const routeName = '/checkout';

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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
        title: const Text('Checkout'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.selectedProducts.length,
        itemBuilder: (context, index) {
          final product = widget.selectedProducts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.file(
                    File(
                      product.imagePath,
                    ),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(FormattedRupiah.formatRupiah(
                          product.price * product.purchased)),
                      const SizedBox(height: 8),
                      Text('Jumlah: ${product.purchased}'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Total: ${FormattedRupiah.formatRupiah(widget.selectedProducts.fold(0, (previousValue, element) => previousValue + (element.price * element.purchased * 1.0)))}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SpaceHeight(8.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    minimumSize: const Size(double.infinity, 48.0),
                  ),
                  child: const Text('Checkout',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Checkout'),
                          content: Text(
                              'Total pembayaran: ${FormattedRupiah.formatRupiah(widget.selectedProducts.fold(0, (previousValue, element) => previousValue + (element.price * element.purchased * 1.0)))}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  for (var product in widget.selectedProducts) {
                                    if (product.purchased > 0) {
                                      product.quantity -= product.purchased;

                                      ProductDatabase.instance
                                          .updateProductQuantity(product);

                                      product.purchased = 0;
                                    }
                                  }
                                });

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                  (Route<dynamic> route) => false,
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: AppColors.green,
                                    content: Row(
                                      children: [
                                        Icon(Icons.check,
                                            color: AppColors.darkBlue),
                                        SizedBox(width: 8),
                                        Text('Yeay!!! Pembayaran berhasil!',
                                            style: TextStyle(
                                                color: AppColors.darkBlue)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Bayar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
