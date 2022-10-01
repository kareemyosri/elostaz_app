import 'package:elostaz_app/modules/Cart/bloc/cart_bloc.dart';
import 'package:elostaz_app/share/components/indi_deal_card.dart';
import 'package:elostaz_app/share/components/tab_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../share/components/order_card.dart';
import '../../share/constants/colors.dart';
import '../../share/utils/screen_utils.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.cartStatus == CartStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.cartStatus == CartStatus.empty) {
          return const EmptyCartScreen();
        }
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(16.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'My Cart',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.search,
                      color: kPrimaryGreen,
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(16.0),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.books.length,
                    itemBuilder: (context, index) {
                      return OrderCard(
                        book: state.books[index],
                      );
                    }),

                // Column(
                //   children: [
                //     Column(
                //       children: [
                //         OrderCard(
                //           isSelected: true,
                //           onTapHandler: () {},
                //         ),
                //         OrderCard(
                //           onTapHandler: () {},
                //         ),
                //         SizedBox(
                //           height: getProportionateScreenHeight(8.0),
                //         ),
                //       ],
                //     )
                //   ],
                // ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total (${state.itemCount})',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '${state.totalPrice} EGP',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const StadiumBorder(),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            Size.fromHeight(
                              getProportionateScreenHeight(48),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Buy Now'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(24.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(16.0),
          ),
          Image.asset('assets/images/empty_cart_illu.png'),
          SizedBox(
            height: getProportionateScreenHeight(16.0),
          ),
          Text(
            'Oops your cart is empty',
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(16.0),
          ),
          Text(
            'It seems nothing in here. Explore more and wishlist some items',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: kTextColorAccent,
                ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(16.0),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              'Start Shopping',
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(16.0),
          ),
          const TabTitle(
            title: 'Recommendation for you',
            padding: 0,
          ),
          SizedBox(
            height: getProportionateScreenHeight(220),
            child: Row(
              children: [
                const Expanded(
                  child: IndiDealCard(
                    noPadding: true,
                    isSelected: true,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(8),
                ),
                const Expanded(
                  child: IndiDealCard(
                    noPadding: true,
                    isSelected: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
