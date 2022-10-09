import 'package:flutter/material.dart';
import 'package:flutter_application_1/general_cubit/cubit.dart';
import 'package:flutter_application_1/general_cubit/states.dart';
import 'package:flutter_application_1/shared/component/components/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralShopStates>(
      listener: (cotext, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                children: [
                  defaultTextFormField(
                    onSubmitted: (String value) {
                      GeneralCubit.get(context).searchObject(text: value);
                    },
                    controller: searchController,
                    text: 'seach',
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'search something';
                      }
                    },
                    prefix: Icons.search,
                    isPass: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (state is ShopSearchLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 30,
                  ),
                  if (state is ShopSearchSucesssState)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildProductsItem(
                          context,
                          GeneralCubit.get(context)
                              .searchmodel!
                              .data!
                              .data![index],
                              hasOldPrice: false
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 3,
                        ),
                        itemCount: GeneralCubit.get(context)
                            .searchmodel!
                            .data!
                            .data!
                            .length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
