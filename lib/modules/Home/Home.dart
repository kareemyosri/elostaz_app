import 'package:elostaz_app/modules/Home/bloc/product_bloc.dart';
import 'package:elostaz_app/modules/product_details.dart/productDetailsScreen.dart';
import 'package:elostaz_app/share/components/indi_deal_card_with_discount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../share/utils/screen_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
//gggg
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'All Products',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //HorizontalFruitsScroll(),
            BlocConsumer<ProductBloc, ProductState>(
              listener: (BuildContext context, state) {},
              builder: (BuildContext context, state) {
                if (state is ProductEmpty) {
                } else if (state is ProductError) {
                } else if (state is ProductLoaded) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: getProportionateScreenHeight(8.0),
                      ),
                      itemCount: state.books.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/ProductDetailsScreen',
                              arguments: ProductDetailsScreen(
                                book: state.books[index],
                              ));
                        },
                        child: IndiDealCardWithDiscount(
                          book: state.books[index],
                          isLeft: index % 2 == 0,
                          isSelected: index == 0,
                          addHandler: () {
                            // Flushbar(
                            //   flushbarPosition: FlushbarPosition.TOP,
                            //   duration: const Duration(seconds: 3),
                            //   backgroundColor: kPrimaryRed,
                            //   icon: const Icon(Icons.car_crash),
                            //   padding: EdgeInsets.symmetric(
                            //     vertical: getProportionateScreenHeight(24.0),
                            //   ),
                            //   margin: EdgeInsets.only(
                            //     top: getProportionateScreenHeight(
                            //       32,
                            //     ),
                            //   ),
                            //   message:
                            //       'Free shipping with a minimum purchase of \$ 100',
                            // ).show(context);
                          },
                        ),
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
    );
  }
}
