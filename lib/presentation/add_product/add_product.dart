import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pos_cerebrum/data/models/request/product.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../core/theme/colors.dart';
import '../../data/datasources/local/product_local_datasource.dart';
import '../home/home_page.dart';
import 'widget/form_box.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  static const routeName = '/add_product';

  @override
  // ignore: library_private_types_in_public_api
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController? imageController;
  File? _selectedImage;

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    imageController = TextEditingController();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
    super.initState();
  }

  Future<void> _showImageSourceDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImageFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        imageController!.text = pickedFile.path;
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        imageController!.text = pickedFile.path;
      });
    }
  }

  Future<void> _addProduct() async {
    if (_selectedImage != null) {
      final newProduct = Product(
        imagePath: _selectedImage!.path,
        title: titleController.text,
        description: descriptionController.text,
        price: double.tryParse(priceController.text) ?? 0,
        quantity: int.tryParse(quantityController.text) ?? 1,
      );

      await ProductDatabase.instance.insertProduct(newProduct);
      log('Product added: ${newProduct.title}, Quantity: ${newProduct.quantity}');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image!')),
      );
    }
  }

  @override
  void dispose() {
    imageController = TextEditingController();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: AppColors.primary),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            FormBoxWidget(
              controller: titleController,
              labelText: 'Name Product',
              maxLines: 1,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 12),
            FormBoxWidget(
              controller: descriptionController,
              labelText: 'Description',
              maxLines: 1,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 12),
            FormBoxWidget(
              controller: quantityController,
              labelText: 'Quantity',
              maxLines: 1,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            FormBoxWidget(
              controller: priceController,
              labelText: 'Price',
              maxLines: 1,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Image Product',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _selectedImage != null
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                    ),
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                      height: 160,
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      await _showImageSourceDialog();
                    },
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                  ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBlue,
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                minimumSize: const Size(double.infinity, 48.0),
              ),
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    priceController.text.isNotEmpty &&
                    quantityController.text.isNotEmpty &&
                    _selectedImage != null) {
                  setState(() {
                    _addProduct();
                  });

                  titleController.clear();
                  descriptionController.clear();
                  priceController.clear();
                  quantityController.clear();
                  _selectedImage = null;

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Success'),
                        content: const Text('Product added successfully!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red[800],
                      content: const Text('Mohon isi semua field'),
                    ),
                  );
                }
              },
              child: const Text('Add Product',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
