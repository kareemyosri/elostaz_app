import 'package:another_flushbar/flushbar.dart';
import 'package:elostaz_app/share/components/indi_deal_card_with_discount.dart';
import 'package:flutter/material.dart';

import '../../share/components/custom_app_bar.dart';
import '../../share/constants/colors.dart';
import '../../share/utils/screen_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Products',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //HorizontalFruitsScroll(),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: getProportionateScreenHeight(8.0),
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    // Navigator.of(context)
                    //     .pushNamed(DragonFruitScreen.routeName);
                  },
                  child: IndiDealCardWithDiscount(
                    isLeft: index % 2 == 0,
                    isSelected: index == 0,
                    addHandler: () {
                      Flushbar(
                        flushbarPosition: FlushbarPosition.TOP,
                        duration: Duration(seconds: 3),
                        backgroundColor: kPrimaryRed,
                        icon: Image.asset('assets/images/delivery.png'),
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(24.0),
                        ),
                        margin: EdgeInsets.only(
                          top: getProportionateScreenHeight(
                            32,
                          ),
                        ),
                        message:
                            'Free shipping with a minimum purchase of \$ 100',
                      )..show(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
