import 'package:flutter/material.dart';
import 'package:loginepanc/models/product.dart';
import 'package:loginepanc/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class ProductGridItem extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final product = Provider.of<Product>(context, listen: false);
     final cart = Provider.of<Cart>(context, listen: false);
      // listen: true, //provider está escutabdo as mudanças e refletindo na interface gráfica 
      // //o listen define se esta escutando as notificações
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
          ) ,
          onTap: (){
            Navigator.of(context).pushNamed(
            AppRoutes.PRODUCT_DETAIL,
            arguments: product,
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) =>IconButton(
              onPressed: () {
                product.toggleFavorite(); 
              },
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border ),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              cart.addItem(product);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:Text('Produto adicionado com sucesso!'),//qnd clico no carrinho 
                 duration: Duration(seconds: 2),
                 action: SnackBarAction(
                  label: 'DESFAZER',
                  onPressed: (){
                    cart.removeSingleItem(product.id); 
                  },
                 
                 ),
                  ),
              );
            },
          ),
        ),
      ),
    );
  }
}