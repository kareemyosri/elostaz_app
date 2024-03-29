import 'package:elostaz_app/models/bookModel/BookModel.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import 'discount_text.dart';

class IndiDealCardWithDiscount extends StatelessWidget {
  final bool isLeft;
  final bool isSelected;
  final VoidCallback addHandler;
  final BookModelWithCategory book;

  const IndiDealCardWithDiscount({
    Key? key,
    required this.isLeft,
    required this.isSelected,
    required this.addHandler,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isLeft ? getProportionateScreenWidth(16.0) : 0,
        right: isLeft ? 0 : getProportionateScreenWidth(16.0),
      ),
      child: Container(
        padding: EdgeInsets.all(
          getProportionateScreenWidth(8.0),
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(
              8,
            ),
          ),
          boxShadow: [
            isSelected
                ? BoxShadow(
                    color: kShadowColor,
                    offset: Offset(
                      getProportionateScreenWidth(24),
                      getProportionateScreenWidth(40),
                    ),
                    blurRadius: 80,
                  )
                : const BoxShadow(color: Colors.transparent),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: kGreyShade5,
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(8.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(8.0),
                  ),
                  DiscoutText(percent: book.bookModel.discountPercent),
                  const Spacer(),
                  Text(
                    book.bookModel.name,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    book.categoryModel.name,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColorAccent,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Divider.png'),
                          ),
                        ),
                        child: Text(
                          '${book.bookModel.oldPrice}',
                          style: const TextStyle(
                            color: kTextColorAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(8.0),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${book.bookModel.price}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: addHandler,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        fillColor: kPrimaryGreen,
                        constraints: BoxConstraints.tightFor(
                          width: getProportionateScreenWidth(
                            40,
                          ),
                          height: getProportionateScreenWidth(
                            40,
                          ),
                        ),
                        elevation: 0,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
