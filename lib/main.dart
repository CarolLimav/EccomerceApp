import 'package:flutter/material.dart';
import 'package:loginepanc/models/cart.dart';
import 'package:loginepanc/models/order_list.dart';
import 'package:loginepanc/models/product_list.dart';
import 'package:loginepanc/pages/cart_page.dart';
import 'package:loginepanc/pages/orders_page.dart';
import 'package:loginepanc/pages/product_detail_page.dart';
import 'package:loginepanc/pages/product_form_page.dart';
import 'package:loginepanc/pages/product_page.dart';
import 'package:loginepanc/pages/products_overview_page.dart';
import 'package:loginepanc/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new ProductList(),),
        ChangeNotifierProvider(create: (_) => Cart(),),
        ChangeNotifierProvider(create: (_) => OrderList(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato',
        ),
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
          AppRoutes.CART: (ctx) => CartPage(), 
         AppRoutes.HOME: (ctx) => ProductsOverviewPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(), 
          AppRoutes.PRODUCTS: (ctx) => ProductsPage(),
           AppRoutes.PRODUCT_FORM: (ctx) => ProductFormPage(),
        },
        debugShowCheckedModeBanner: false, //tirar debug que aparece inicialmente 
      ),
    );
  }
}

