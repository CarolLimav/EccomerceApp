// import 'dart:convert';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../models/product.dart';

// class ProductList with ChangeNotifier {
//   final _baseUrl =
//       'https://ecommerce-app-84f00-default-rtdb.firebaseio.com/products';
//   List<Product> _items = []; //qro iniciar com uma lista vazia

//   List<Product> get items => [..._items];
//   List<Product> get favoriteItems =>
//       _items.where((prod) => prod.isFavorite).toList();

//   int get itemsCount {
//     return _items.length;
//   }

//   Future<void> loadProcuts() async {
//     _items.clear();
//     final response = await http.get(
//       Uri.parse('$_baseUrl.json'),
//     );
//     if (response.body == 'null') return;
//     Map<String, dynamic> data = jsonDecode(response.body);
//     data.forEach((productId, productData) {
//       _items.add(
//         Product(
//           id: productId,
//           name: productData[' name'],
//           description: productData[' description'],
//           price: productData['price'],
//           imageUrl: productData[' imageUrl'],
//           isFavorite: productData['isFavorite'],
//         ),
//       );
//     });
//     notifyListeners();
//   }

//   Future<void> saveProduct(Map<String, Object> data) {
//     bool hasId = data['id'] != null;
//     final product = Product(
//         id: hasId
//             ? data['id'] as String
//             : Random()
//                 .nextDouble()
//                 .toString(), //se tiver id usar o id de data se não usa um aleatório
//         name: data['name'] as String,
//         price: data['price'] as double,
//         description: data['description'] as String,
//         imageUrl: data['imageUrl'] as String);
//     if (hasId) {
//       return updateProduct(product);
//     } else {
//       return addProduct(product);
//     }
//   }

//   Future<void> addProduct(Product product) async {
//     final response = await http.post(
//       //opcional criar a variavel, fiz por conta da formatação
//       Uri.parse('$_baseUrl.json'), //firebase pede o json no final como obrigatório
//       body: jsonEncode(
//         {
//           "name": product.name,
//           "description": product.description,
//           "price": product.price,
//           "imagteUrl": product.imageUrl,
//           "isFavorite": product.isFavorite
//         },
//       ),
//     ); //colocar logo o then se não tivese criado uma variável
//     final id = jsonDecode(response.body)['name']; //cosigo pegar o id
//     // print(jsonDecode(response.body)); //qro ver oq veio no corpo da resposta
//     _items.add(Product(
//       id: id, //id q obtive do firebase
//       name: product.name,
//       price: product.price,
//       description: product.description,
//       imageUrl: product.imageUrl,
//       isFavorite: product.isFavorite,
//     )); //assim que obtenho resposta ele adiciona
//     notifyListeners();
//     // return future.then<void>((response) {

//     //   // print('Depois que a resposta voltar do firebase');
//     // });
//     // print('na sequência sem esperar resposta do firebase');
//   }

//   Future<void> updateProduct(Product product) async {
//     int index = _items.indexWhere((p) => p.id == product.id);
//     if (index >= 0) {
//      await http.patch(
//       //opcional criar a variavel, fiz por conta da formatação
//       Uri.parse('$_baseUrl/${product.id}.json'), //firebase pede o json no final como obrigatório
//       body: jsonEncode(
//         {
//           "name": product.name,
//           "description": product.description,
//           "price": product.price,
//           "imagteUrl": product.imageUrl,
//           //sem favorito pq favorito não altera 
//         },
//       ),
//     );
//       _items[index] = product;
//       notifyListeners();
//     }
//   }

//   void removeProduct(Product product) {
//     int index = _items.indexWhere((p) => p.id == product.id);
//     if (index >= 0) {
//       _items.removeWhere((p) => p.id == product.id);
//       notifyListeners();
//     }
//   }
// }
// // class ProductList with ChangeNotifier{
// //   List<Product> _items = dummyProducts;

// //   List<Product> get items => [...items];
// //    List<Product> get favoriteItems => _items.where((prod)=> prod.isFavorite).toList();

// //   void addProduct (Product product){
// //     _items.add(product);
// //     notifyListeners(); //atualiza a mudança notificando os interessados
// //   }
// //   }//padrão observer ver depois
// // }
// // bool _showFavoriteOnly = false;

// //   List<Product> get items {//se estiver verdadeiro retorna a lista filtrada
// //     if(_showFavoriteOnly){//where é um filtro para procurar
// //       return _items.where((prod)=> prod.isFavorite).toList();
// //     }//caso não retorna todos
// //     return [...items];
// //   }

// // void showFavoriteOnly (){
// //   _showFavoriteOnly = true;
// //   notifyListeners();
// // }
// // void showAll (){
// //   _showFavoriteOnly = false;
// //   notifyListeners(); //preciso para que funcione
// // }

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginepanc/models/product.dart';

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://ecommerce-app-84f00-default-rtdb.firebaseio.com/products';
  final List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('$_baseUrl.json'),
    );
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$_baseUrl.json'),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('$_baseUrl/${product.id}.json'),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('$_baseUrl/${product.id}'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
      }
    }
  }
}

// bool _showFavoriteOnly = false;

//   List<Product> get items {
//     if (_showFavoriteOnly) {
//       return _items.where((prod) => prod.isFavorite).toList();
//     }
//     return [..._items];
//   }

//   void showFavoriteOnly() {
//     _showFavoriteOnly = true;
//     notifyListeners();
//   }

//   void showAll() {
//     _showFavoriteOnly = false;
//     notifyListeners();
//   }
