// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

enum ProductCountAction { initial, increment, decrement }

enum ProductTabs { details, reviews }

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProduct extends ProductEvent {}

class ChangeProductTab extends ProductEvent {
  final ProductTabs productTabs;

  const ChangeProductTab(this.productTabs);
  @override
  List<Object> get props => [productTabs];
}
