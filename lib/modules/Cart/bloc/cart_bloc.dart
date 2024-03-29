import 'package:elostaz_app/models/bookModel/BookModel.dart';
import 'package:elostaz_app/repo/db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required DatabaseRepo databaseRepo})
      : _databaseRepo = databaseRepo,
        super(const CartState()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCard);
    on<UpdateItemAmount>(_onUpdateItemAmount);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<CheckItem>(_onCheckItem);
  }
  final DatabaseRepo _databaseRepo;
  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) {
    emit(state.copyWith(cartStatus: CartStatus.loading));
    return emit.onEach<List<CartItemModel>>(_databaseRepo.loadCartItems(),
        onData: (products) {
      if (products.isEmpty) {
        emit(state.copyWith(cartStatus: CartStatus.empty));
        return;
      }
      List<BookModelWithCategory> booksData = [];
      products.forEach((item) async {
        BookModelWithCategory bookData =
            await _databaseRepo.getBookItemData(item.id);
        bookData = bookData.copyWith(
          bookModel: bookData.bookModel.copyWith(quantity: item.quantity),
        );
        booksData = booksData..add(bookData);
        int itemCount = booksData.fold<int>(
            0,
            (previousValue, element) =>
                previousValue + element.bookModel.quantity);
        double totalPrice = booksData.fold<double>(
            0,
            (previousValue, element) =>
                previousValue + element.bookModel.totalPrice);
        emit(state.copyWith(
          books: booksData,
          itemCount: itemCount,
          totalPrice: totalPrice,
          cartStatus: CartStatus.loaded,
        ));
        // print(booksData);
      });
    });
  }

  Future<void> _onAddToCard(AddToCart event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(addToCartStatus: AddToCartStatus.loading));
      if (!state.books.contains(event.item)) {
        await _databaseRepo.addItemToCart(event.item.bookId, event.quantity);
        emit(state.copyWith(addToCartStatus: AddToCartStatus.success));
        emit(state.copyWith(addToCartStatus: AddToCartStatus.initial));
      } else {
        emit(state.copyWith(addToCartStatus: AddToCartStatus.alreadyExists));
      }
    } catch (_) {
      emit(state.copyWith(addToCartStatus: AddToCartStatus.error));
    }
  }

  Future<void> _onUpdateItemAmount(
      UpdateItemAmount event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(updateCartItemStatus: UpdateCartItemStatus.loading));

      switch (event.action) {
        case CartItemAction.increment:
          await _databaseRepo.updateItemQuantity(
              event.book.bookModel.bookId, 1);
          break;
        case CartItemAction.decrement:
          if (event.book.bookModel.quantity > 1) {
            await _databaseRepo.updateItemQuantity(
                event.book.bookModel.bookId, -1);
          }
          break;
      }
      emit(state.copyWith(updateCartItemStatus: UpdateCartItemStatus.success));
      emit(state.copyWith(updateCartItemStatus: UpdateCartItemStatus.initial));
    } catch (_) {
      emit(state.copyWith(updateCartItemStatus: UpdateCartItemStatus.error));
    }
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCart event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(removeCartItemStatus: RemoveCartItemStatus.loading));
      await _databaseRepo.removeItemFromCart(event.itemId);
      emit(state.copyWith(removeCartItemStatus: RemoveCartItemStatus.success));
      emit(state.copyWith(removeCartItemStatus: RemoveCartItemStatus.initial));
    } catch (_) {
      emit(state.copyWith(removeCartItemStatus: RemoveCartItemStatus.error));
    }
  }

  Future<void> _onCheckItem(CheckItem event, Emitter<CartState> emit) async {
    // if (state.cartStatus == CartStatus.inital) {
    //   var value = add(LoadCart());
    //   await value.first;
    // }
    for (BookModelWithCategory book in state.books) {
      if (book.bookModel.bookId == event.item.bookModel.bookId) {
        emit(state.copyWith(isExists: true));
        return;
      }
    }
    emit(state.copyWith(isExists: false));
  }
}
