import 'package:flutter/material.dart';
import 'package:flutter_application_1/general_cubit/cubit.dart';
import 'package:flutter_application_1/screens/login_screen/loginscreen.dart';
import 'package:flutter_application_1/screens/onboarding_screen/onboardscreen.dart';
import 'package:flutter_application_1/shared/network/local/sharedpref.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextFormField({
  void Function(String value)? onSubmitted,
  required TextEditingController? controller,
  required String text,
  required String? Function(String? v)? validate,
  required IconData? prefix,
  IconData? suffix,
  required bool? isPass,
  TextInputType? keyType,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmitted,
      validator: validate,
      controller: controller,
      obscureText: isPass!,
      keyboardType: keyType,
      decoration: InputDecoration(
        suffix: Icon(suffix),
        labelText: text,
        prefixIcon: Icon(prefix),
        border: const OutlineInputBorder(),
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, WARNING, ERROR }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }

  return color;
}

String? token = '';

void signOut(context) {
  CachHelper.removeData(key: 'token').then(
    (value) => {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ShopLoginScreen(),
        ),
      ),
    },
  );
}

/// to clear all Caches use this method
void clearCahch(context) {
  CachHelper.clearData().then(
    (value) => {
      CachHelper.saveData(
        key: 'isDark',
        value: false,
      ),
      CachHelper.saveData(
        key: 'onBoarding',
        value: false,
      ),
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoarding(),
        ),
      ),
    },
  );
}

void navigatTo(context, Widget widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigatewWithoutFinish(context, Widget widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget buildProductsItem(
  context,
  dynamic model, {
  bool hasOldPrice = true,
}) =>
    Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage('${model.image}'),
                    width: 150,
                    height: 150,
                  ),

                  model.discount != 0 && hasOldPrice
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
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${model.name}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${model.price}\$',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        model.discount != 0 && hasOldPrice
                            ? Text(
                                '${model.oldPrice}\$',
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              )
                            : const Text(''),
                        // const Expanded(child: SizedBox()),
                        IconButton(
                          onPressed: () {
                            GeneralCubit.get(context)
                                .changeFavorites(model.id!);
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
                    Expanded(
                      child: Text(
                        '${model.description}\$',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
