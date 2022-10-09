import 'package:flutter/material.dart';
import 'package:flutter_application_1/general_cubit/cubit.dart';
import 'package:flutter_application_1/general_cubit/states.dart';
import 'package:flutter_application_1/models/categries_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorisScreen extends StatelessWidget {
  const CategorisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
          itemBuilder: (context, index) => buildCategoryItem(
                GeneralCubit.get(context).categoryModel!.data!.data![index],context
              ),
          separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
          itemCount:
              GeneralCubit.get(context).categoryModel!.data!.data!.length),
    );
  }

  Widget buildCategoryItem(CategoriesDataModel model,context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                '${model.image}',
              ),
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              '${model.name}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 70, 9, 9),
            ),
          ],
        ),
      );
}
