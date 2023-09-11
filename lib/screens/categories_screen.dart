import 'package:flutter/material.dart';
//import 'package:mobile8_final_project/mock_data.dart';
import 'package:mobile8_final_project/screens/products_in_category_screen.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';
import 'package:mobile8_final_project/screens/widgets/drawer.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const AppBarWidget(
            title: 'Ярмаркет',

          ),
          drawer: const DrawerWidget(),
          body: Container(
            decoration:  const BoxDecoration(
              //color: Color(0xffd9f1ce),
              color: Color(0xffd6edff),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: GridView.builder(
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 5/4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: categories.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductsInCategoryScreen(
                                        categId: categories[index]['category'],
                                      )),
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 1,
                            child: Column(
                              children: [

                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              categories[index]['image']))),
                                ),
                                Text(
                                  categories[index]['name'],
                                  style: const TextStyle(
                                      fontSize: 16,),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
