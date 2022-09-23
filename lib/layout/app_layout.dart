import 'package:elostaz_app/layout/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.notification_add)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeindex(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.home,
                  ),
                  label: cubit.titles[cubit.currentIndex]),
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.search,
                  ),
                  label: cubit.titles[cubit.currentIndex]),
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.shopping_cart,
                  ),
                  label: cubit.titles[cubit.currentIndex]),
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.person,
                  ),
                  label: cubit.titles[cubit.currentIndex]),
            ],
          ),
        );
      },
    );
  }
}
