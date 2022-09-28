import 'package:elostaz_app/layout/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/bookModel/BookModel.dart';
import '../../share/components/custom_app_bar.dart';
import '../../share/components/custom_input_button.dart';
import '../../share/components/discount_text.dart';
import '../../share/components/fruit_title.dart';
import '../../share/components/image_placeholder.dart';
import '../../share/components/indi_deal_card.dart';
import '../../share/components/price_tag.dart';
import '../../share/components/quantity_input.dart';
import '../../share/components/tab_title.dart';
import '../../share/constants/colors.dart';
import '../../share/utils/screen_utils.dart';



class ProductDetailsScreen extends StatelessWidget {

  final BookModel model;


  ProductDetailsScreen({super.key,
  required this.model,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AppCubit,AppState>(
          listener: (BuildContext context, state) {  },
          builder: (BuildContext context, Object? state) {
            var isReviewTab=AppCubit.get(context).isReviewTab;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(
                          model.name,
                          [
                            SizedBox(
                              width: getProportionateScreenWidth(24),
                              child: Image.asset(
                                'assets/images/cart_nav_fill.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(16),
                            ),
                            Icon(
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
                          child: ImagePlaceholder(),
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
                              DiscoutText(),
                              SizedBox(
                                height: getProportionateScreenHeight(8),
                              ),
                              FruitTitle(title: model.name),
                              SizedBox(
                                height: getProportionateScreenHeight(8),
                              ),
                              Text(
                                model.category!.name,
                                style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                  color: kTextColorAccent,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PreviousPriceTag(oldprice: model.old_price!),
                                  SizedBox(
                                    width: getProportionateScreenWidth(8),
                                  ),
                                  PriceTag(price:model.price),
                                  Spacer(),
                                  CustomIconButton(Icons.remove, () {
                                    // setState(() {
                                    //   int quantity = int.parse(textController.text);
                                    //   quantity--;
                                    //   textController.text = quantity.toString();
                                    // });
                                    AppCubit.get(context).minusQuantity();
                                  }),
                                  SizedBox(
                                    width: getProportionateScreenWidth(4),
                                  ),
                                  QuantityInput(textController: AppCubit.get(context).textController),
                                  SizedBox(
                                    width: getProportionateScreenWidth(4),
                                  ),
                                  CustomIconButton(Icons.add, () {
                                    // setState(() {
                                    //   int quantity = int.parse(textController.text);
                                    //   quantity++;
                                    //   textController.text = quantity.toString();
                                    // });
                                    AppCubit.get(context).plusQuantity();
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
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (!isReviewTab) {
                                            return;
                                          }

                                          // setState(() {
                                          //   isReviewTab = !isReviewTab;
                                          // });
                                          AppCubit.get(context).changeTab();
                                        },
                                        child: DetailSelection(
                                          'Description',
                                          !isReviewTab,
                                        ),
                                      ),
                                    ),
                                    VerticalDivider(
                                      endIndent: getProportionateScreenHeight(4),
                                      indent: getProportionateScreenHeight(4),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (isReviewTab) {
                                            return;
                                          }

                                          // setState(() {
                                          //   isReviewTab = !isReviewTab;
                                          // });
                                          AppCubit.get(context).changeTab();
                                        },
                                        child: DetailSelection(
                                          'Reviews',
                                          isReviewTab,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(16),
                              ),
                              !isReviewTab
                                  ? Text(
                                model.description!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                  color: kTextColorAccent,
                                ),
                              )
                                  : Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                                children: [
                                  ReviewCard(),
                                  ReviewCard(),
                                  OutlinedButton(
                                      onPressed: () {},
                                      child: Text('See All Reviews'))
                                ],
                              ),
                              Divider(
                                height: getProportionateScreenHeight(48),
                              ),
                              TabTitle(
                                title: 'More Like this',
                                padding: 0, seeAll: () {  },
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
                                        addHandler: () {  },
                                      ),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(8),
                                    ),
                                    Expanded(
                                      child: IndiDealCard(
                                        noPadding: true,
                                        isSelected: false, isLeft: false, addHandler: () {  },
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
                            child: Image.asset(
                              'assets/images/cart_nav_fill.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(16),
                      ),
                      Expanded(
                        flex: 4,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Buy Now'),
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
                    UserDetails(),
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
              Icon(Icons.more_vert_rounded),
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
              Text(
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

  const DetailSelection(this.text, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      decoration: isSelected
          ? ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(8.0),
            ),
          ),
          shadows: [
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
  final int oldprice;
  const PreviousPriceTag({
    Key? key,
    required this.oldprice
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
          '${oldprice}',
          style: TextStyle(
            color: kFailColor,
          ),
        ),
      ),
    );
  }
}
