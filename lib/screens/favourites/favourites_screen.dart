import 'package:flutter/material.dart';
import 'package:flutter_application_1/general_cubit/cubit.dart';
import 'package:flutter_application_1/general_cubit/states.dart';
import 'package:flutter_application_1/shared/component/components/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is! ShopGetFavoritesLoadingState
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildProductsItem(
                  context,
                  GeneralCubit.get(context).favoritesModel!.data!.data![index].product,
                  hasOldPrice: true,
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 1),
                itemCount: GeneralCubit.get(context)
                    .favoritesModel!
                    .data!
                    .data!
                    .length,
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }


}
