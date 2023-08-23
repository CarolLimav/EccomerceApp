import 'package:flutter/cupertino.dart';
import 'package:loginepanc/components/product_grid_item.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductGrid extends StatelessWidget {

final bool showFavoriteOnly;
ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final  provider = Provider.of<ProductList>(context); //loadedProducts é o nome que dei a lista 
    final List<Product> loadedProducts = showFavoriteOnly ? provider.favoriteItems : provider.items;
    return GridView.builder(
      padding: EdgeInsets.all(10), //o padding é pra as laterais não ficarem coladas 
      itemCount:loadedProducts.length, //preciso dizer quantas coisas o gridView irá renderizar pq se não a lista ficará infinita 
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value:  loadedProducts[i],//////],
        child: ProductGridItem(),
          ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(//área dentro de algo que é rolável 
        crossAxisCount: 2 ,  //isso significa que eu qeuro que ele exiba 2 produtos por linha
        childAspectRatio: 3/2, //aqui eu digo a relção que existe entre altura e largura 
        crossAxisSpacing: 10,//espaçamento no eixo cruzado 
        mainAxisSpacing: 10, //eixo principal
    
        ),
    );
  }
}