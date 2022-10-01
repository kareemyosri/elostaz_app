import 'package:elostaz_app/models/bookModel/BookModel.dart';
import 'package:elostaz_app/modules/Cart/bloc/cart_bloc.dart';
import 'package:elostaz_app/share/components/custom_input_button.dart';
import 'package:elostaz_app/share/components/small_quantity_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class OrderCard extends StatelessWidget {
  final BookModelWithCategory book;
  const OrderCard({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(8.0),
            ),
            backgroundColor: kAlertColor,
            label: 'Delete',
            icon: Icons.remove_circle,
            onPressed: (BuildContext context) {
              context
                  .read<CartBloc>()
                  .add(RemoveFromCart(book.bookModel.bookId));
            },
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(8.0),
            ),
            backgroundColor: kAlertColor,
            label: 'Delete',
            icon: Icons.remove_circle,
            onPressed: (BuildContext context) {
              context
                  .read<CartBloc>()
                  .add(RemoveFromCart(book.bookModel.bookId));
            },
          ),
        ],
      ),
      child: Container(
        height: getProportionateScreenHeight(88),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(8.0),
            ),
          ),
          color: isSelected ? Colors.white : Colors.transparent,
          shadows: isSelected
              ? [
                  BoxShadow(
                    color: kShadowColor,
                    offset: Offset(
                      getProportionateScreenWidth(24),
                      getProportionateScreenWidth(40),
                    ),
                    blurRadius: 80,
                  )
                ]
              : [],
        ),
        padding: EdgeInsets.all(
          getProportionateScreenWidth(4.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: getProportionateScreenWidth(80),
              decoration: ShapeDecoration(
                color: kGreyShade5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(8.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(8),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    book.bookModel.name,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    book.categoryModel.name,
                    style: TextStyle(
                      color: kTextColorAccent,
                      fontSize: getProportionateScreenWidth(
                        12,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${book.bookModel.totalPrice} EGP',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      CustomIconButton(
                        Icons.remove,
                        () {
                          context.read<CartBloc>().add(UpdateItemAmount(
                              book.bookModel.bookId, CartItemAction.decrement));
                        },
                        size: 32,
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(4),
                      ),
                      SmallQuantityInput(
                        value: book.bookModel.quantity,
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(4),
                      ),
                      CustomIconButton(
                        Icons.add,
                        () {
                          context.read<CartBloc>().add(UpdateItemAmount(
                              book.bookModel.bookId, CartItemAction.increment));
                        },
                        size: 32,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class OrderCard extends StatefulWidget {
//   const OrderCard({
//     Key? key,
//     this.isSelected = false,
//     required this.onTapHandler,
//   }) : super(key: key);

//   final bool isSelected;
//   final Function() onTapHandler;

//   @override
//   State<OrderCard> createState() => _OrderCardState();
// }

// class _OrderCardState extends State<OrderCard> {
//   final textController = TextEditingController(text: '1');
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }
