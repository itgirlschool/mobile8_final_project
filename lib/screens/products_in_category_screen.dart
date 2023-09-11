import 'package:flutter/material.dart';
import 'package:mobile8_final_project/data/dto/product_dto.dart';
import 'package:mobile8_final_project/screens/product_screen.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';
import 'package:mobile8_final_project/screens/widgets/cart_buttons.dart';

//import '../mock_data.dart';

//import 'data/dto/product_dto.dart';

List<ProductDto> products = [
  ProductDto(
    id: "1",
    name: 'Молоко Parmalat ffffffffffffff',
    price: 100,
    quantity: 1,
    description: '1л',
    category: '1',
    image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  ),
  ProductDto(
    id: "2",
    name: 'Хлеб бородинский ',
    price: 50,
    quantity: 1,
    description: 'Черный, 400гр, Зерновой край',
    category: '3',
    image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fborodinski.jpg?alt=media&token=90e2523f-4372-4ef8-9cba-5be5feb2f20e',
  ),
  ProductDto(
    id: "3",
    name: 'Молоко Parmalat',
    price: 100,
    quantity: 1,
    description: '1л',
    category: '1',
    image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  ),
  ProductDto(
    id: "4",
    name: 'Молоко Parmalat',
    price: 100,
    quantity: 1,
    description: '1л',
    category: '1',
    image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  ),
  ProductDto(
    id: "5",
    name: 'Молоко Parmalat',
    price: 100,
    quantity: 1,
    description: '1л',
    category: '1',
    image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  ),
  ProductDto(
    id: "6",
    name: 'Молоко Parmalat',
    price: 100,
    quantity: 1,
    description: '1л',
    category: '1',
    image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  ),
  ProductDto(
    id: "7",
    name: 'Молоко Parmalat',
    price: 100,
    quantity: 1,
    description: '1л',
    category: '1',
    image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  ),
  ProductDto(
    id: "8",
    name: 'Молоко Parmalat',
    price: 100,
    quantity: 1,
    description: '1л',
    category: '1',
    image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  ),
  ProductDto(
    id: "9",
    name: 'Молоко Parmalat',
    price: 100,
    quantity: 1,
    description: '1л',
    category: '1',
    image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  ),
  ProductDto(
    id: "10",
    name: 'Молоко Parmalat',
    price: 100,
    quantity: 1,
    description: '1л',
    category: '1',
    image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  ),
];

List categories = [
  {
    "name": "Молочные продукты",
    "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fmilk.png?alt=media&token=0c8081f0-ef0a-4b25-965e-3379a1d1e523",
    "category": "1",
  },
  {
    "name": "Мясо",
    "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fmeat.png?alt=media&token=fa75f3da-27a1-4cb5-8f6c-38f4fc12cbfc",
    "category": "2",
  },
  {
    "name": "Хлеб",
    "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fbread.png?alt=media&token=35d8ddfc-7652-4fdb-af23-e840827b997a",
    "category": "3",
  },
  {
    "name": "Мясо",
    "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fmeat.png?alt=media&token=fa75f3da-27a1-4cb5-8f6c-38f4fc12cbfc",
    "category": "2",
  },
  {
    "name": "Мясо",
    "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fmeat.png?alt=media&token=fa75f3da-27a1-4cb5-8f6c-38f4fc12cbfc",
    "category": "2",
  },
  {
    "name": "Мясо",
    "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fmeat.png?alt=media&token=fa75f3da-27a1-4cb5-8f6c-38f4fc12cbfc",
    "category": "2",
  },
  {
    "name": "Мясо",
    "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fmeat.png?alt=media&token=fa75f3da-27a1-4cb5-8f6c-38f4fc12cbfc",
    "category": "2",
  },
  {
    "name": "Мясо",
    "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fmeat.png?alt=media&token=fa75f3da-27a1-4cb5-8f6c-38f4fc12cbfc",
    "category": "2",
  },
  {
    "name": "Мясо",
    "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fmeat.png?alt=media&token=fa75f3da-27a1-4cb5-8f6c-38f4fc12cbfc",
    "category": "2",
  },
  {
    "name": "Мясо",
    "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fmeat.png?alt=media&token=fa75f3da-27a1-4cb5-8f6c-38f4fc12cbfc",
    "category": "2",
  },
  {
    "name": "Мясо",
    "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fmeat.png?alt=media&token=fa75f3da-27a1-4cb5-8f6c-38f4fc12cbfc",
    "category": "2",
  },
];

class ProductsInCategoryScreen extends StatefulWidget {
  final String categId;

  const ProductsInCategoryScreen({super.key, required this.categId});

  @override
  State<ProductsInCategoryScreen> createState() => _ProductsInCategoryScreenState(categId);
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
          body: Container(
            height: MediaQuery.of(context).size.height,
            color: const Color(0xfffae3ec),
            //color: Color(0xffe2f5d6),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: GridView.builder(
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      //childAspectRatio: 9/8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
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
                        child: Card(
                          color: Colors.white,
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
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    categProd[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CartButtons(
                                  onPressedAdd: () {},
                                  onPressedRemove: () {},
                                  isInStock: true,
                                  quantity: 0,
                                  price: 100,
                                  sizeFactor: 1.1,
                                  onlyPrice: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
