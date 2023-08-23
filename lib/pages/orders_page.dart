import 'package:flutter/material.dart';
import 'package:loginepanc/components/app_drawer.dart';
import 'package:provider/provider.dart';

import '../components/order.dart';
import '../models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
      title: Text('Meus pedidos'),
      ),
      drawer: AppDrawer(),
      body:ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i],),
        
        ) ,
    );
  }
}