import 'package:flutter/material.dart';
import 'package:flutter_app_test/widgets/product_card.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final produtos = [
      {
        "nome": "Café",
        "descricao": "Café torrado e moído",
        "preco": "R\$ 12,00"
      },
      {
        "nome": "Leite",
        "descricao": "Leite integral",
        "preco": "R\$ 4,50"
      },
      {
        "nome": "Pão",
        "descricao": "Pão francês",
        "preco": "R\$ 0,50"
      }
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Lista de Produtos')),
        body: ListView.builder(
          itemCount: produtos.length,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.all(8.0),
            child: ProductCard(produto: produtos[index]),
          ),
        ),
      ),
    );
  }
}