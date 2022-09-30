import 'package:elostaz_app/layout/cubit/app_cubit.dart';
import 'package:elostaz_app/modules/Cart/bloc/cart_bloc.dart';
import 'package:elostaz_app/modules/product_details/cubit/product_count_cubit.dart';
import 'package:elostaz_app/share/components/book_title.dart';
import 'package:elostaz_app/share/components/quantity_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/bookModel/BookModel.dart';
import '../../share/components/custom_app_bar.dart';
import '../../share/components/custom_input_button.dart';
import '../../share/components/discount_text.dart';
import '../../share/components/image_placeholder.dart';
import '../../share/components/indi_deal_card.dart';
import '../../share/components/price_tag.dart';
import '../../share/components/tab_title.dart';
import '../../share/constants/colors.dart';
import '../../share/utils/screen_utils.dart';

class ProductDetailsScreen extends StatelessWidget {
  final BookModelWithCategory book;

  const ProductDetailsScreen({
    super.key,
    required this.book,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AppCubit, AppState>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(
                          book.bookModel.name,
                          [
                            SizedBox(
                                width: getProportionateScreenWidth(24),
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Theme.of(context).primaryColor,
                                )),
                            SizedBox(
                              width: getProportionateScreenWidth(16),
                            ),
                            const Icon(
                              Icons.share,
                              color: kPrimaryGreen,
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(300),
                          width: double.infinity,
                          child: const ImagePlaceholder(),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(16.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DiscoutText(
                                  percent: book.bookModel.discountPercent),
                              SizedBox(
                                height: getProportionateScreenHeight(8),
                              ),
                              BookTitle(title: book.bookModel.name),
                              SizedBox(
                                height: getProportionateScreenHeight(8),
                              ),
                              Text(
                                book.categoryModel.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color: kTextColorAccent,
                                    ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PreviousPriceTag(
                                      oldprice: book.bookModel.oldPrice!),
                                  SizedBox(
                                    width: getProportionateScreenWidth(8),
                                  ),
                                  PriceTag(price: book.bookModel.price),
                                  const Spacer(),
                                  CustomIconButton(Icons.remove, () {
                                    ProductCountCubit.get(context)
                                        .decrementCount();
                                    HapticFeedback.heavyImpact();
                                  }),
                                  SizedBox(
                                    width: getProportionateScreenWidth(4),
                                  ),
                                  QuantityInput(
                                      textController:
                                          ProductCountCubit.get(context)
                                              .textController),
                                  SizedBox(
                                    width: getProportionateScreenWidth(4),
                                  ),
                                  CustomIconButton(Icons.add, () {
                                    ProductCountCubit.get(context)
                                        .incrementCount();

                                    HapticFeedback.heavyImpact();
                                  }),
                                ],
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(8.0),
                              ),
                              Container(
                                height: getProportionateScreenHeight(
                                  32,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: getProportionateScreenHeight(2),
                                  horizontal: getProportionateScreenWidth(4),
                                ),
                                decoration: ShapeDecoration(
                                  color: kFillColorThird,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(8.0),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // Expanded(
                                    //   child: GestureDetector(
                                    //     onTap: () {},
                                    //     child: DetailSelection(
                                    //       'Description',
                                    //       !isReviewTab,
                                    //     ),
                                    //   ),
                                    // ),
                                    VerticalDivider(
                                      endIndent:
                                          getProportionateScreenHeight(4),
                                      indent: getProportionateScreenHeight(4),
                                    ),
                                    // Expanded(
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       // AppCubit.get(context).changeTab();
                                    //     },
                                    //     child: DetailSelection(
                                    //       'Reviews',
                                    //       isReviewTab,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(16),
                              ),
                              // !isReviewTab
                              // ?
                              Text(
                                book.bookModel.description!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color: kTextColorAccent,
                                    ),
                              ),
                              // :
                              // Column(
                              //     crossAxisAlignment:
                              //         CrossAxisAlignment.stretch,
                              //     children: [
                              //       const ReviewCard(),
                              //       const ReviewCard(),
                              //       OutlinedButton(
                              //           onPressed: () {},
                              //           child:
                              //               const Text('See All Reviews'))
                              //     ],
                              //   ),
                              Divider(
                                height: getProportionateScreenHeight(48),
                              ),
                              TabTitle(
                                title: 'More Like this',
                                padding: 0,
                                seeAll: () {},
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(220),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: IndiDealCard(
                                        noPadding: true,
                                        isSelected: true,
                                        isLeft: false, //don't know
                                        addHandler: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(8),
                                    ),
                                    Expanded(
                                      child: IndiDealCard(
                                        noPadding: true,
                                        isSelected: false,
                                        isLeft: false,
                                        addHandler: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(48),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(16.0),
                    vertical: getProportionateScreenWidth(10.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigator.of(context)
                            //     .pushNamed(OrderSummaryScreen.routeName);
                          },
                          child: SizedBox(
                            width: getProportionateScreenWidth(32),
                            child: const Icon(Icons.shopping_cart),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(16),
                      ),
                      Expanded(
                        flex: 4,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<CartBloc>().add(AddToCart(
                                  book.bookModel,
                                  ProductCountCubit.get(context).state,
                                ));
                          },
                          child: const Text('Buy Now'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: getProportionateScreenHeight(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: kGreyShade5,
                      radius: getProportionateScreenWidth(24.0),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(8),
                    ),
                    const UserDetails(),
                  ],
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: kTextColorAccent,
                      ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shoo Thar Mien',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(17.0),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Icon(Icons.more_vert_rounded),
            ],
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/star_rating.png',
              ),
              SizedBox(
                width: getProportionateScreenWidth(4),
              ),
              Image.asset(
                'assets/images/star_rating.png',
              ),
              SizedBox(
                width: getProportionateScreenWidth(4),
              ),
              Image.asset(
                'assets/images/star_rating.png',
              ),
              SizedBox(
                width: getProportionateScreenWidth(4),
              ),
              Image.asset(
                'assets/images/star_rating.png',
              ),
              SizedBox(
                width: getProportionateScreenWidth(4),
              ),
              Image.asset(
                'assets/images/star_rating.png',
              ),
              const Text(
                '29 February, 2099',
                style: TextStyle(
                  color: kTextColorAccent,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DetailSelection extends StatelessWidget {
  final String text;
  final bool isSelected;

  const DetailSelection(this.text, this.isSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: isSelected
          ? ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  getProportionateScreenWidth(8.0),
                ),
              ),
              shadows: const [
                  BoxShadow(
                    color: kShadowColor,
                    offset: Offset(0, 3),
                    blurRadius: 8,
                  )
                ])
          : null,
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class PreviousPriceTag extends StatelessWidget {
  final dynamic oldprice;
  const PreviousPriceTag({Key? key, required this.oldprice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Divider2.png'),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(8),
        ),
        decoration: ShapeDecoration(
          color: kFailColor.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(8.0),
            ),
          ),
        ),
        child: Text(
          '$oldprice',
          style: const TextStyle(
            color: kFailColor,
          ),
        ),
      ),
    );
  }
}
