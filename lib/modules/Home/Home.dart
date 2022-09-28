import 'package:another_flushbar/flushbar.dart';
import 'package:elostaz_app/layout/cubit/app_cubit.dart';
import 'package:elostaz_app/share/components/indi_deal_card_with_discount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../share/constants/colors.dart';
import '../../share/utils/screen_utils.dart';
import '../product_details/productDetailsScreen.dart';

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
            BlocConsumer<AppCubit,AppState>(
              listener: (BuildContext context, state) {  },
              builder: (BuildContext context, Object? state) {
                var model =AppCubit.get(context).products;
                if(model.length >0) {
                  return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: getProportionateScreenHeight(8.0),
                    ),
                    itemCount: model.length ,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(model:model[index] ,)));
                          
                      },
                      child: IndiDealCardWithDiscount(
                        model: model[index],
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
                else{
                  return Center(child: CircularProgressIndicator());

                }
              },

            )
          ],
        ),
      ),
    );
  }
}
