import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:task_week_1/ListOfProducts.dart';
//import 'package: task_wee_1/ProdList.dart';

class ProductScreen extends StatelessWidget {
  final ProductDatatModel product;
  const ProductScreen({
    super.key,
    required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white60,
          centerTitle: true,
          title: Text(
            product.productName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      backgroundColor: Color(0xfffB37F88),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'product',
              child: Image.network(
                product.productImage,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height:20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.productName,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height:20),

            Text(
              'Price : ${product.productPrice}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Rate : ${product.productRate}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
