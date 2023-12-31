import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loginepanc/models/product.dart';

import 'cart_item.dart';

class Cart with ChangeNotifier{
  Map <String, CartItem> _items ={};

  Map<String, CartItem> get items{
    return {..._items};
  }

  int get itemsCount{
    return _items.length; 
  }
  //metodo para calcular o total 
  double get totalAmount{
    double total = 0.0;
    _items.forEach((key, CartItem) { 
      total += CartItem.price * CartItem.quantity;
    });
    return total; 
  }

  void addItem(Product product){
    if(_items.containsKey(product.id)){
      _items.update(product.id, (existingItem) => CartItem(id: existingItem.id, productId: existingItem.productId, name: existingItem.name, quantity: 
      existingItem.quantity + 1, //+1 pq quero adicionar mais 1 
      price: existingItem.price,),);
  }else{//putIfAbsent insira se não estiver presente 
    _items.putIfAbsent(product.id, () => CartItem(id: Random().nextDouble().toString(), productId: product.id, name: product.name, quantity: 1, price: product.price,),);
  }
  notifyListeners(); 
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners(); 
  }

  void removeSingleItem(String productId){
    if(!_items.containsKey(productId)){
      return;
    }else{
       _items.update(productId, (existingItem) => CartItem(id: existingItem.id, productId: existingItem.productId, name: existingItem.name, quantity: 
      existingItem.quantity - 1, //+1 pq quero adicionar mais 1 
      price: existingItem.price,),);
    }
    notifyListeners(); 
  }

  void clear(){
    _items={};
    notifyListeners(); 
  }
}