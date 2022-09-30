part of 'cart_bloc.dart';

enum CartStatus { inital, loading, loaded, empty, error }

enum AddToCartStatus { initial, loading, success, error }

enum UpdateCartItemStatus { initial, loading, success, error }

enum RemoveCartItemStatus { initial, loading, success, error }

enum CartItemAction { increment, decrement }

class CartState extends Equatable {
  const CartState({
    this.books = const <BookModelWithCategory>[],
    this.cartStatus = CartStatus.inital,
    this.addToCartStatus = AddToCartStatus.initial,
    this.updateCartItemStatus = UpdateCartItemStatus.initial,
    this.removeCartItemStatus = RemoveCartItemStatus.initial,
  });
  final List<BookModelWithCategory> books;
  final CartStatus cartStatus;
  final AddToCartStatus addToCartStatus;
  final UpdateCartItemStatus updateCartItemStatus;
  final RemoveCartItemStatus removeCartItemStatus;
  @override
  List<Object> get props => [
        books,
        cartStatus,
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
  }) {
    return CartState(
      books: books ?? this.books,
      cartStatus: cartStatus ?? this.cartStatus,
      addToCartStatus: addToCartStatus ?? this.addToCartStatus,
      updateCartItemStatus: updateCartItemStatus ?? this.updateCartItemStatus,
      removeCartItemStatus: removeCartItemStatus ?? this.removeCartItemStatus,
    );
  }
}
