import 'package:flutter/material.dart';
import 'package:mobile8_final_project/data/dto/product_dto.dart';
import 'package:mobile8_final_project/screens/product_screen.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';

import '../mock_data.dart';

class ProductsInCategoryScreen extends StatefulWidget {
  final String categId;
  const ProductsInCategoryScreen({super.key, required this.categId});

  @override
  State<ProductsInCategoryScreen> createState() =>
      _ProductsInCategoryScreenState(categId);
}

class _ProductsInCategoryScreenState extends State<ProductsInCategoryScreen> {
  String categId;

  _ProductsInCategoryScreenState(this.categId);

  @override
  Widget build(BuildContext context) {
    List<ProductDto> categProd = products
        .where(
          (element) => element.category == categId,
        )
        .toList();
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarWidget(
            title: categories[int.parse(categId) - 1]['name'],
          ),
          body: SingleChildScrollView(
            child: GridView.builder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: categProd.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductScreen(
                                  product: categProd[index],
                                )),
                      );
                    },
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: NetworkImage(
                                      categProd[index].image,
                                    ))),
                          ),
                          Text(categProd[index].name),
                          Text('${categProd[index].price} ₽')
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
