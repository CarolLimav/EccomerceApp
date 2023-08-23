import 'package:flutter/material.dart';
import 'package:loginepanc/models/cart_item.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem; 
  const CartItemWidget(
    this.cartItem,{
    super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart ,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin:EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4, 
        ),
      ),
      confirmDismiss: (_){
        return showDialog<bool>( //future pq a reposta fica esperando no dialog
          context: context, 
          builder: (ctx) => AlertDialog(
            title: Text('Tem Certeza?'),
            content:Text('Quer remover o item do carrinho?') ,
         actions: [
          TextButton(onPressed: (){
            Navigator.of(ctx).pop(false);
          }, child: Text('Não'),),
           TextButton(onPressed: (){
             Navigator.of(ctx).pop(true);
          }, child: Text('Sim'),)
         ],
          )
          );
        },
      onDismissed:(_) {
        Provider.of<Cart>(context, listen: false).removeItem(cartItem.name);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4, 
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('${cartItem.price}'),
              ),
              
              
              ),
            ) ,
            title: Text(cartItem.name),
            subtitle: Text('Total:R\$ ${cartItem.price * cartItem.quantity}'),
            trailing:Text('${cartItem.quantity} x') ,
          ),
        ),
      ),
    );
  }
}