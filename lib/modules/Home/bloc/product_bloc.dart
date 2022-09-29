import 'package:elostaz_app/models/bookModel/BookModel.dart';
import 'package:elostaz_app/repo/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required DatabaseRepo databaseRepo})
      : _databaseRepo = databaseRepo,
        super(ProductInitial()) {
    // on<ProductEvent>((event, emit) {});

    // on<ChangeProductTab>((event, emit) {
    //   emit(ChangeProductTabStat);
    // });

    on<LoadProduct>(_onLoadProducts);
  }
  static ProductBloc get(BuildContext context) => context.read<ProductBloc>();
  final DatabaseRepo _databaseRepo;
  Future<void> _onLoadProducts(ProductEvent event, Emitter<ProductState> emit) {
    return emit.onEach<List<Future<BookModelWithCategory>>>(
        _databaseRepo.getBooksData(), onData: (books) {
      if (books.isEmpty) {
        emit(ProductEmpty());
        return;
      }
      List<BookModelWithCategory> booksData = [];
      return books.forEach((element) async {
        BookModelWithCategory bookModelWithCategory = await element;
        emit(ProductLoaded(booksData..add(bookModelWithCategory)));
      });
    });
  }
}
