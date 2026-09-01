import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget{

  final Map<String, String> produto;
// const serve para evidenciar widgets imutáveis
// usar {} dentro de () do construtor para parâmetros nomeados
  const ProductCard({super.key, required this.produto}); 

  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 3,
              color: Colors.blueGrey[120],
              shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                     ),
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto["nome"]!,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(produto["descricao"]!),
                    Text(produto["preco"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      )),
                  ],
                ),
              ),
            );
    
  }

}