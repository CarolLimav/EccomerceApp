// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:loginepanc/models/product.dart';
// import 'package:loginepanc/models/product_list.dart';
// import 'package:provider/provider.dart';

// class ProductFormPage extends StatefulWidget {
//   const ProductFormPage({super.key});

//   @override
//   State<ProductFormPage> createState() => _ProductFormPageState();
// }

// class _ProductFormPageState extends State<ProductFormPage> {
//   @override
//   Widget build(BuildContext context) {
//    final _priceFocus = FocusNode();
//    final _descriptionFocus = FocusNode();
//    final _imageUrlFocus = FocusNode();
//   final _imageUrlController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final _formData = Map<String, Object>();

//   void updateImage(){
//     setState(() {

//     });
//   }
//   @override
//   void initState(){
//     super.initState();
//     _imageUrlFocus.addListener(updateImage);
//   }

//     @override
//     void didChangeDependencies(){
//       super.didChangeDependencies();

//       if(_formData.isEmpty){
//         final arg = ModalRoute.of(context)?.settings.arguments;

//         if(arg != null){
//           final product = arg as Product;
//          _formData['id'] = product.id;
//          _formData['name'] = product.name;
//          _formData['price'] = product.price;
//          _formData['description'] = product.description;
//          _formData['imageUrl'] = product.imageUrl;

//          _imageUrlController.text = product.imageUrl;
//         }
//       }
//     }

//     @override
//    void dispose(){
//     super.dispose();
//     _priceFocus.dispose();
//     _descriptionFocus.dispose();
//     _imageUrlFocus.removeListener(updateImage);
//     _imageUrlFocus.dispose();
//    }

//    bool isValidImageUrl(String url){
//     bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
//     bool endWithFile = url.toLowerCase().endsWith('png') ||  url.toLowerCase().endsWith('jpg')  ||
//     url.toLowerCase().endsWith('jpeg');
//    return isValidUrl && endWithFile;
//    }

//     void _submitForm(){
//       setState(() {
//          final isValid =  _formKey.currentState?.validate() ?? false;

//          if(!isValid){
//           return;
//          }

//        _formKey.currentState?.save();

//       Provider.of<ProductList>(context, listen:false).saveProduct(_formData);
//       Navigator.of(context).pop();

//       });
//     }

//     return Scaffold (
//       appBar: AppBar(
//         title: Text('Formulário de Produto'),
//         actions: [
//           IconButton(onPressed:_submitForm ,
//            icon: Icon(Icons.save),
//            )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 initialValue: _formData['name']?.toString(),
//                 decoration: InputDecoration(labelText: 'Nome'),
//                 textInputAction: TextInputAction.next, //botão seguinte ao invés de concluído no teclado
//                 onFieldSubmitted:(_){
//                   FocusScope.of(context).requestFocus(_priceFocus);
//                 },
//                 onSaved: (name) => _formData ['name'] = name ?? '',
//                 validator: (_name){
//                   final name = _name ?? '';
//                   if(name.trim().isEmpty){
//                     return 'Nome é obrigatório';
//                   }

//                    if(name.trim().length < 3){
//                     return 'Nome precisa no mínimo de 3 letras ';
//                   }
//                   return null;
//                 },
//               ),
//                 TextFormField(
//                 initialValue: _formData['price']?.toString(),//? caso o valor não esteja setado
//                 decoration: InputDecoration(labelText: 'Preço'),
//                 textInputAction: TextInputAction.next, //botão seguinte ao invés de concluído no teclado
//                 focusNode: _priceFocus,
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 onFieldSubmitted: (_){
//                   FocusScope.of(context).requestFocus(_descriptionFocus);
//                 },
//                  onSaved: (price) => _formData ['name'] = double.parse(price ?? '0'),
//                  validator: (_price){
//                   final priceString = _price ?? '';
//                   final price = double.tryParse(priceString) ?? -1;

//                   if( price <= 0){
//                     return 'Informe um preço válido';
//                   }
//                   return null;
//                  },
//               ),
//                TextFormField(
//                  initialValue: _formData['description']?.toString(),
//                 decoration: InputDecoration(labelText: 'Descrição'),
//                 // textInputAction: TextInputAction.next, //botão seguinte ao invés de concluído no teclado
//                 focusNode:_descriptionFocus ,
//                 keyboardType:  TextInputType.multiline,
//                 maxLines: 3,
//                 onSaved: (description) => _formData ['description'] = description ?? '',
//                   validator: (_description){
//                   final name = _description ?? '';
//                   if(name.trim().isEmpty){
//                     return 'Descrição é obrigatório';
//                   }

//                    if(name.trim().length < 10){
//                     return 'Descrição precisa no mínimo de 10 letras';
//                   }
//                   return null;
//                 },
//               ),
//                Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                  children: [
//                    Expanded(
//                      child: TextFormField(
//                       decoration: const InputDecoration(labelText: 'Url da Imagem'),
//                       // textInputAction: TextInputAction.next, //botão seguinte ao invés de concluído no teclado
//                       focusNode:_imageUrlFocus ,
//                       textInputAction: TextInputAction.done,
//                       keyboardType: TextInputType.url,
//                       controller: _imageUrlController,
//                       onFieldSubmitted: (_) => _submitForm(),
//                       onSaved: (imageUrl) => _formData ['imageUrl'] = imageUrl ?? '',
//                       validator: (_imageUrl){
//                         final imageUrl = _imageUrl ?? '';
//                         if(! isValidImageUrl(imageUrl)){
//                           return 'Informe uma Url válida';
//                         };
//                         return null; //indica que  a url é válida
//                       },
//                                  ),
//                    ),
//                    Container(
//                     height: 100,
//                     width: 100,
//                     margin: const EdgeInsets.only(
//                       top: 10,
//                       left: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey,
//                         width: 1,
//                       )
//                     ),
//                     alignment: Alignment.center,
//                     child:_imageUrlController.text.isEmpty ? const Text('Informe a Url') :
//                     FittedBox(
//                       child: Image.network(
//                         _imageUrlController.text,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                    )
//                  ],
//                ),
//             ],
//           ) ,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  Future <void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);
    try{
     await Provider.of<ProductList>(
      context,
      listen: false,
    ).saveProduct(_formData);
    }catch(error){

      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Ocorreu um erro para salvar o produto.'),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }finally{//serve pra executar mesmo com erro ou de forma bem sucedida 
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(), //enquanto aguarda o retorno do future fica carregando 
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['name']?.toString(),
                      decoration: const InputDecoration(labelText: 'Nome'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (name) => _formData['name'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';

                        if (name.trim().isEmpty) {
                          return 'Nome é obrigatório.';
                        }

                        if (name.trim().length < 3) {
                          return 'Nome precisa no mínimo de 3 letras.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price']?.toString(),
                      decoration: const InputDecoration(labelText: 'Preço'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                      onSaved: (price) =>
                          _formData['price'] = double.parse(price ?? '0'),
                      validator: (_price) {
                        final priceString = _price ?? '';
                        final price = double.tryParse(priceString) ?? -1;

                        if (price <= 0) {
                          return 'Informe um preço válido.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description']?.toString(),
                      decoration: const InputDecoration(labelText: 'Descrição'),
                      focusNode: _descriptionFocus,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (description) =>
                          _formData['description'] = description ?? '',
                      validator: (_description) {
                        final description = _description ?? '';

                        if (description.trim().isEmpty) {
                          return 'Descrição é obrigatória.';
                        }

                        if (description.trim().length < 10) {
                          return 'Descrição precisa no mínimo de 10 letras.';
                        }

                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Url da Imagem'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocus,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) => _submitForm(),
                            onSaved: (imageUrl) =>
                                _formData['imageUrl'] = imageUrl ?? '',
                            validator: (_imageUrl) {
                              final imageUrl = _imageUrl ?? '';

                              if (!isValidImageUrl(imageUrl)) {
                                return 'Informe uma Url válida!';
                              }

                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _imageUrlController.text.isEmpty
                              ? const Text('Informe a Url')
                              : Image.network(_imageUrlController.text),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
