import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_cerebrum/core/utils/format_rupiah.dart';

import '../../bloc/get_weather/get_weather_bloc.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/spaces.dart';
import '../../data/datasources/local/product_local_datasource.dart';
import '../../data/models/request/product.dart';
import '../add_product/add_product.dart';
import '../checkout/checkout_page.dart';
import '../detail_product/detail_product.dart';
import 'widgets/weather_card.dart';
import 'widgets/search_product_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  List<Product> filteredProducts = [];

  TextEditingController? _searchController;
  final ValueNotifier<List<Product>> _productsNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    context.read<GetWeatherBloc>().add(DoGetWeatherEvent());
    _searchController = TextEditingController();
    _fetchProducts();
    _searchController!.addListener(() {
      _filterProducts();
    });
  }

  Future<void> _fetchProducts() async {
    final data = await ProductDatabase.instance.fetchProducts();
    setState(() {
      products = data;
      filteredProducts = List.from(products);
      _productsNotifier.value = List.from(products);
      _filterProducts();
    });
  }

  void _filterProducts() {
    final query = _searchController!.text.toLowerCase().trim();

    setState(() {
      filteredProducts = products.where((product) {
        final matches = product.title.toLowerCase().contains(query);

        return matches;
      }).toList();
    });
  }

  double _calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var product in products) {
      totalPrice += product.price * product.purchased;
    }
    return totalPrice;
  }

  @override
  void dispose() {
    _searchController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: AppColors.bgColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProductPage.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        children: [
          const SpaceHeight(16.0),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Perkiraan Cuaca',
              style: TextStyle(
                color: AppColors.darkBlue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SpaceHeight(16.0),
          BlocBuilder<GetWeatherBloc, GetWeatherState>(
            builder: (context, state) {
              if (state is GetWeatherLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetWeatherLoaded) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.dataWeather.data!
                        .map((data) => data.cuaca!)
                        .expand((cuaca) => cuaca)
                        .expand((item) => item)
                        .length,
                    itemBuilder: (context, index) {
                      final allWeatherData = state.dataWeather.data!
                          .map((data) => data.cuaca!)
                          .expand((cuaca) => cuaca)
                          .expand((item) => item)
                          .toList();

                      final cuaca = allWeatherData[index];

                      return WeatherCard(
                        temperature: cuaca.t?.toDouble() ?? 0.0,
                        weatherDesc: cuaca.weatherDesc ?? 'N/A',
                        date: cuaca.datetime?.toString() ?? 'N/A',
                        image: cuaca.image ?? '',
                      );
                    },
                  ),
                );
              } else if (state is GetWeatherError) {
                return Center(
                  child: Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                  ),
                );
              } else {
                return const SizedBox(
                  child: Text('No Data'),
                );
              }
            },
          ),
          const SpaceHeight(24.0),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Katalog Produk',
              style: TextStyle(
                color: AppColors.darkBlue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SpaceHeight(16.0),
          SearchProduct(
            controller: _searchController!,
            label: 'Search Product',
            prefixIcon: const Icon(Icons.search, color: AppColors.primary),
            obscureText: false,
            showLabel: true,
          ),
          const SpaceHeight(16.0),
          FutureBuilder<List<Product>>(
              future: ProductDatabase.instance.fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading products'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products found'));
                }
                return ValueListenableBuilder<List<Product>>(
                  valueListenable: _productsNotifier,
                  builder: (context, productList, _) {
                    return GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16.0),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailProductPage(
                                  imagePath: product.imagePath,
                                  title: product.title,
                                  description: product.description,
                                  price: product.price,
                                  quantity: product.quantity,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: AppColors.grey,
                              border: const Border(
                                bottom: BorderSide(
                                  color: AppColors.primary,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16.0)),
                                  child: SizedBox(
                                    height: 110,
                                    child: Image.file(
                                      File(product.imagePath),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        FormattedRupiah.formatRupiah(
                                            product.price),
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          IconButton.outlined(
                                            style: IconButton.styleFrom(
                                              side: const BorderSide(
                                                  color: AppColors.primary,
                                                  width: 1.0),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if (product.purchased > 0) {
                                                  product.purchased--;
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.remove,
                                            ),
                                          ),
                                          Text('${product.purchased}'),
                                          IconButton.outlined(
                                            style: IconButton.styleFrom(
                                              side: const BorderSide(
                                                  color: AppColors.primary,
                                                  width: 1.0),
                                            ),
                                            onPressed: () {
                                              setState(
                                                () {
                                                  if (product.purchased <
                                                      product.quantity) {
                                                    product.purchased++;
                                                  }
                                                },
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SpaceHeight(4.0),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
          const SpaceHeight(100.0),
        ],
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkBlue,
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            minimumSize: const Size(double.infinity, 48.0),
          ),
          onPressed: () async {
            // Navigasi ke halaman checkout
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutPage(
                  selectedProducts: products
                      .where((product) => product.purchased > 0)
                      .toList(),
                ),
              ),
            );

            if (result != null && result is List<Product>) {
              setState(() {
                products = result;
              });
            }
          },
          child: Text(FormattedRupiah.formatRupiah(_calculateTotalPrice()),
              style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
