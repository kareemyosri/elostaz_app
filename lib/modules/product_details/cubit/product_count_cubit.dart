import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_count_state.dart';

class ProductCountCubit extends Cubit<int> {
  ProductCountCubit() : super(1) {
    textController = TextEditingController(text: state.toString());
  }
  static ProductCountCubit get(BuildContext context) =>
      context.read<ProductCountCubit>();
  late TextEditingController textController;

  void incrementCount() {
    emit(state + 1);
    textController.text = state.toString();
  }

  void decrementCount() {
    if (state > 0) {
      emit(state - 1);
      textController.text = state.toString();
    }
  }
}
