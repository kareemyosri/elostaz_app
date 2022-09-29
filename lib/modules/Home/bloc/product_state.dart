// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<BookModelWithCategory> books;

  const ProductLoaded(this.books);

  @override
  List<Object> get props => [books];
}

class ProductEmpty extends ProductState {}

class ProductError extends ProductState {}

class ProductCountState extends ProductState {
  final int count;

  const ProductCountState({this.count = 0});
  @override
  List<Object> get props => [count];

  ProductCountState copyWith({
    int? count,
  }) {
    return ProductCountState(
      count: count ?? this.count,
    );
  }
}

class ChangeProductTabState extends ProductState {
  final ProductTabs productTabs;

  const ChangeProductTabState(this.productTabs);
  @override
  List<Object> get props => [productTabs];
  ChangeProductTab copyWith({
    ProductTabs? productTabs,
  }) {
    return ChangeProductTab(
      productTabs ?? this.productTabs,
    );
  }
}
