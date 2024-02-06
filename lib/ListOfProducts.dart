import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:task_week_1/ProductScreen.dart';

class ProdList extends StatefulWidget {
  const ProdList({
    Key? key,
  }) : super(key : key);

  @override
  State<ProdList> createState() => _ProdListState();
}

class _ProdListState extends State<ProdList> {
  final List<ProductDatatModel> ListofProduct = [];

  Future<void> getProductFromApi() async {
    try {
      print('getProductsFromApi');
      final response = await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        Map<String, dynamic> apiData = jsonDecode(response.body);
        print(apiData);

        for (Map<String, dynamic> p in apiData['products']) {
          ProductDatatModel product = ProductDatatModel.fromMap(p);
          ListofProduct.add(product);
        }
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getProductFromApi().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        centerTitle: true,
        title: Text(
          'Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [],
      ),
      backgroundColor: Color(0xfffB37F88),
      body: GridView.builder(
        itemCount: ListofProduct.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductScreen(
                      product: ListofProduct[index],
                    ),
                ));
            },
            child: Container(
              height:200,
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex:2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Hero(
                        tag: 'product',
                        child: Image.network(
                          ListofProduct[index].productImage,
                          fit: BoxFit.fill,
                          height: 160,
                          width: 200,
                        ),
                      ),
                    ),
                  ),
                  //const SizedBox(height: 20),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('   ' + ListofProduct[index].productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        //const SizedBox(height: 10),
                      if(ListofProduct[index].prodStock > 50)
                        Text('   Available : ' + ListofProduct[index].prodStock.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                        if(ListofProduct[index].prodStock < 50)
                          Text('   Limited Are Available',
                             style: const TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 14,
                               color: Color(0xfff8b0000),
                             ),
                          ),
                        Text('   Price : ' + ListofProduct[index].productPrice.toString() + ' \$',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 14,
                        ),
                        ),
                        //const SizedBox(height: 10),
                        RatingBarIndicator(
                         itemBuilder: (context, index) => const Icon(
                           Icons.star,
                           color: Colors.amber,
                         ),
                          rating: ListofProduct[index].productRate.toDouble(),
                          itemCount: 5,
                          itemSize: 15,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
    gridDelegate:
    const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
      ),
    );
  }
}
class ProductDatatModel {
  String productName;
  int productPrice;
  String productImage;
  num productRate;
  int prodStock;

  ProductDatatModel({
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productRate,
    required this.prodStock,

  });

  factory ProductDatatModel.fromMap(Map<String, dynamic> json) {
    return ProductDatatModel(
      productName: json['title'],
      productPrice: json['price'],
      productImage: json['thumbnail'],
      productRate: json['rating'],
      prodStock: json['stock'],
    );
  }
}
