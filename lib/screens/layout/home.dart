import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/search_screen/search_screen.dart';
import 'package:flutter_application_1/shared/component/components/shared.dart';
import 'package:flutter_application_1/general_cubit/cubit.dart';
import 'package:flutter_application_1/general_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GeneralCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Shabana Store',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  navigatewWithoutFinish(
                    context,
                    SearchScreen(),
                  );
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                // color: Colors.white,
                onPressed: () {
                  GeneralCubit.get(context).changeThemeMode();
                },
                icon: const Icon(Icons.dark_mode),
              ),
            ],
          ),
          drawer: Drawer(),
          body: cubit.bottomNavSceens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            elevation: 20,
            items: cubit.items,
            onTap: (index) {
              cubit.changeBottom(index);
            },
          ),
        );
      },
    );
  }
}
