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
  }
  final DatabaseRepo _databaseRepo;
  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) {
    emit(state.copyWith(cartStatus: CartStatus.loading));
    return emit.onEach<List<CartItemModel>>(_databaseRepo.loadCartItems(),
        onData: (products) {
      // print(products);

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
        print(bookData);
        emit(state.copyWith(
          books: booksData..add(bookData),
          cartStatus: CartStatus.loaded,
        ));
        print(booksData);
      });
    });
  }

  Future<void> _onAddToCard(AddToCart event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(addToCartStatus: AddToCartStatus.loading));
      await _databaseRepo.addItemToCart(event.item.bookId, event.quantity);
      emit(state.copyWith(addToCartStatus: AddToCartStatus.success));
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
          await _databaseRepo.updateItemQuantity(event.bookId, 1);
          break;
        case CartItemAction.decrement:
          await _databaseRepo.updateItemQuantity(event.bookId, -1);
          break;
      }
      emit(state.copyWith(updateCartItemStatus: UpdateCartItemStatus.success));
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
    } catch (_) {
      emit(state.copyWith(removeCartItemStatus: RemoveCartItemStatus.error));
    }
  }
}
