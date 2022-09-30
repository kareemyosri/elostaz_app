import 'package:elostaz_app/modules/Home/bloc/product_bloc.dart';
import 'package:elostaz_app/share/components/indi_deal_card_with_discount.dart';
import 'package:elostaz_app/share/components/tab_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../share/utils/screen_utils.dart';
import '../product_details/productDetailsScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TabTitle(
              title: 'All Products',
              padding: 0,
            ),
            //HorizontalFruitsScroll(),
            BlocConsumer<ProductBloc, ProductState>(
              listener: (BuildContext context, state) {},
              builder: (BuildContext context, state) {
                if (state is ProductEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.clear),
                      SizedBox(height: 20),
                      Text('No Products to show.')
                    ],
                  );
                } else if (state is ProductError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.error),
                      SizedBox(height: 20),
                      Text('Unkown error happened.')
                    ],
                  );
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
                                  book: state.books[index]));
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
