part of 'cart_bloc.dart';

enum CartStatus { inital, loading, loaded, empty, error }

enum AddToCartStatus { initial, loading, success, alreadyExists, error }

enum UpdateCartItemStatus { initial, loading, success, error }

enum RemoveCartItemStatus { initial, loading, success, error }

enum CartItemAction { increment, decrement }

class CartState extends Equatable {
  const CartState({
    this.books = const <BookModelWithCategory>[],
    this.itemCount = 0,
    this.totalPrice = 0.0,
    this.isExists = false,
    this.cartStatus = CartStatus.inital,
    this.addToCartStatus = AddToCartStatus.initial,
    this.updateCartItemStatus = UpdateCartItemStatus.initial,
    this.removeCartItemStatus = RemoveCartItemStatus.initial,
  });
  final List<BookModelWithCategory> books;
  final int itemCount;
  final double totalPrice;
  final CartStatus cartStatus;
  final AddToCartStatus addToCartStatus;
  final UpdateCartItemStatus updateCartItemStatus;
  final RemoveCartItemStatus removeCartItemStatus;
  final bool isExists;
  @override
  List<Object> get props => [
        books,
        cartStatus,
        itemCount,
        totalPrice,
        isExists,
        addToCartStatus,
        updateCartItemStatus,
        removeCartItemStatus
      ];

  CartState copyWith({
    List<BookModelWithCategory>? books,
    CartStatus? cartStatus,
    AddToCartStatus? addToCartStatus,
    UpdateCartItemStatus? updateCartItemStatus,
    RemoveCartItemStatus? removeCartItemStatus,
    int? itemCount,
    double? totalPrice,
    bool? isExists,
  }) {
    return CartState(
      books: books ?? this.books,
      cartStatus: cartStatus ?? this.cartStatus,
      itemCount: itemCount ?? this.itemCount,
      totalPrice: totalPrice ?? this.totalPrice,
      addToCartStatus: addToCartStatus ?? this.addToCartStatus,
      updateCartItemStatus: updateCartItemStatus ?? this.updateCartItemStatus,
      removeCartItemStatus: removeCartItemStatus ?? this.removeCartItemStatus,
      isExists: isExists ?? this.isExists,
    );
  }
}
