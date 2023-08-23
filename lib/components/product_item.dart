import 'package:flutter/material.dart';
import 'package:loginepanc/models/product_list.dart';
import 'package:loginepanc/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
 final Product product;
  const ProductItem(this.product,{super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_FORM,
                arguments: product, 
              );
            },
             icon: Icon(Icons.edit),
             color: Theme.of(context).primaryColor ,
             ),
               IconButton(onPressed: (){
                showDialog<bool>(context: context, 
                builder: (ctx) => AlertDialog(
                  title: Text(
                    'Excluir Produto'
                  ),
                  content: Text('Tem certeza que deseja excluir?'),
                  actions: [
                    TextButton(
                      child: Text(
                        'Não'
                      ),
                      onPressed: () => Navigator.of(ctx).pop(false), 

                      ),
                      TextButton(
                      child: Text(
                        'Sim'
                      ),
                      onPressed: () => Navigator.of(ctx).pop(true),

                      )
                  ],
                )
                ).then((value){
                  if(value ?? false){
                Provider.of<ProductList>(context, listen: false).removeProduct(product);

                  }
                });
                // Provider.of<ProductList>(context, listen: false,).removeProduct(product);
            },
             icon: Icon(Icons.delete),
             color: Theme.of(context).errorColor,
             )
          ],
        ),
      ),
    );
  }
}