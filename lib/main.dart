import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_cerebrum/presentation/checkout/checkout_page.dart';
import 'package:flutter_pos_cerebrum/presentation/home/home_page.dart';
import 'bloc/get_weather/get_weather_bloc.dart';
import 'core/theme/style_theme.dart';
import 'data/datasources/remote/weather_datasource.dart';
import 'presentation/add_product/add_product.dart';
import 'presentation/detail_product/detail_product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetWeatherBloc(WeatherDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter POS Cerebrum',
        debugShowCheckedModeBanner: false,
        theme: StyleTheme.styleTheme(),
        home: const HomePage(),
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          DetailProductPage.routeName: (context) => const DetailProductPage(
              imagePath: '', title: '', description: '', price: 0, quantity: 0),
          AddProductPage.routeName: (context) => const AddProductPage(),
          CheckoutPage.routeName: (context) => const CheckoutPage(
                selectedProducts: [],
              ),
        },
      ),
    );
  }
}
