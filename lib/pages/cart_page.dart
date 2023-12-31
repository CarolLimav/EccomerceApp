import 'package:flutter/material.dart';
import 'package:loginepanc/components/cart_item.dart';
import 'package:loginepanc/models/order_list.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList(); 
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carrinho'
        ),
      ),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 25,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 10),
                Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(
                    'R\$${cart.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.headline6?.color, 
                  ),
                  
                  ),
                
                ),
                Spacer(),
                TextButton(
                child: Text('Comprar'),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed:(){
                  Provider.of<OrderList>(context, listen: false).addOrder(cart);
                  cart.clear();
                } , 
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
          itemBuilder: (ctx, i) => CartItemWidget(items[i]),
        
        ))
      ]),
    );
  }
}