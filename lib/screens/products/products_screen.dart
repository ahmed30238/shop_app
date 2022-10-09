import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/component/components/shared.dart';
import 'package:flutter_application_1/models/categries_model.dart';
import 'package:flutter_application_1/models/home_model.dart';
import 'package:flutter_application_1/general_cubit/cubit.dart';
import 'package:flutter_application_1/general_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavoritesSuccessState) {
          if (!state.model.status) {
            showToast(
              text: state.model.message,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return GeneralCubit.get(context).homeModel != null &&
                GeneralCubit.get(context).categoryModel != null
            ? productsBuilder(
                context: context,
                model: GeneralCubit.get(context).homeModel!,
                catModel: GeneralCubit.get(context).categoryModel!)
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

Widget productsBuilder({
  required HomeModel model,
  required CategoriesModel catModel,
  context,
}) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners!
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 4,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.orange),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 100,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildCategoryItem(catModel.data!.data![index],context),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        ),
                        itemCount: catModel.data!.data!.length,
                        scrollDirection: Axis.horizontal,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'New Products',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.orange),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: .5,
                children: List.generate(
                  model.data!.products!.length,
                  (index) =>
                      buildGridProducts(model.data!.products![index], context),
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildGridProducts(Products model, context) => Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 4, right: 3.6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 4,
                ),

                model.discount != 0
                    ? Positioned(
                        bottom: 5,
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 247, 2, 23),
                          ),
                          child: Center(
                            child: Text(
                              'DISCOUNT ${model.discount}%',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 210, 224, 9),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Text(''),

                // if(model.discount != 0)
              ],
            ),
            Text(
              '${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Row(
              children: [
                Text(
                  '${model.price}\$',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                model.discount != 0
                    ? Text(
                        '${model.oldPrice}\$',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )
                    : const Text(''),
                const Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () {
                    GeneralCubit.get(context).changeFavorites(model.id!);
                  },
                  icon: GeneralCubit.get(context).favorites[model.id]!
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(Icons.favorite_border),
                ),
              ],
            ),
            Text(
              '${model.description}\$',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
Widget buildCategoryItem(CategoriesDataModel model,context) => Stack(
      children: [
        Image(
          image: NetworkImage(
            '${model.image}',
          ),
          fit: BoxFit.cover,
          height: 100,
          width: 100,
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: 100,
            color: Colors.grey.withOpacity(.8),
            child: Text(
              '${model.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
