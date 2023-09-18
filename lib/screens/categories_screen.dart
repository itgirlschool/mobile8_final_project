import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:mobile8_final_project/screens/products_in_category_screen.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';
import 'package:mobile8_final_project/screens/widgets/drawer.dart';
import 'package:mobile8_final_project/screens/widgets/go_to_cart_button.dart';

import '../bloc/categories/categories_bloc.dart';
import '../bloc/categories/categories_state.dart';
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _bloc = CategoriesBloc(GetIt.I.get());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: const DrawerWidget(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: const GoToCartButton(
            price: 300,
          ),
          appBar: const AppBarWidget(
            title: 'Ярмаркет',
          ),
          body: Container(
            decoration: const BoxDecoration(
              //color: Color(0xffd9f1ce),
              color: Color(0xffd6edff),
            ),
            child: BlocProvider(
              create: (_) => _bloc,
              child: BlocBuilder<CategoriesBloc, CategoriesState>(builder: (context, state) {
                return switch (state) {
                  LoadingCategoriesState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  LoadedCategoriesState() => _buildCategories(context, state),
                  ErrorCategoriesState() => const Center(
                      child: Text('Ошибка загрузки категорий'),
                    ),
                };
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context, state) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: GridView.builder(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 5 / 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: state.categories.length,
              itemBuilder: (_, index) {
                return _buildCategory(context, index, state);
              }),
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, int index, state) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductsInCategoryScreen(
                    categId: state.categories[index].id,
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
              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(state.categories[index].image))),
            ),
            Text(
              state.categories[index].name,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
