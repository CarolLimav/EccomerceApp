import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  final String id;
  final String name;
  final String description;
  final double price; //preço 
  final String imageUrl; 
  bool isFavorite; 

  Product({
    required this.id, //tudo que é final eu marco como required 
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    this.isFavorite = false, 
  });
  //método que ajuda a fazer alternância entre o valor do favorito togglr quer dizer alternancia em portugues 
  void toggleFavorite(){
    isFavorite = !isFavorite; //ficará alternando o valor a cada chamada
    notifyListeners(); 
  }
}