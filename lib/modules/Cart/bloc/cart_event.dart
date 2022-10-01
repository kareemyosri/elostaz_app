part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final int quantity;
  final BookModel item;

  const AddToCart(this.item, this.quantity);
  @override
  List<Object> get props => [item, quantity];
}

class RemoveFromCart extends CartEvent {
  final String itemId;

  const RemoveFromCart(this.itemId);
  @override
  List<Object> get props => [itemId];
}

class UpdateItemAmount extends CartEvent {
  final BookModelWithCategory book;
  final CartItemAction action;
  const UpdateItemAmount(this.book, this.action);
  @override
  List<Object> get props => [book, action];
}

class CheckItem extends CartEvent {
  final BookModelWithCategory item;

  const CheckItem(this.item);
  @override
  List<Object> get props => [item];
}
