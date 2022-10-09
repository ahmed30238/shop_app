import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen/shop_app_login_cubit/cubit.dart';
import 'package:flutter_application_1/screens/login_screen/shop_app_login_cubit/states.dart';
import 'package:flutter_application_1/shared/component/components/shared.dart';
import 'package:flutter_application_1/screens/layout/home.dart';
import 'package:flutter_application_1/register_screen/register.dart';
import 'package:flutter_application_1/shared/network/local/sharedpref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          bool pass = ShopCubit.get(context).isShown;

          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(fontSize: 25, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'too short';
                            }
                          },
                          controller: emailController,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'EmailAddress',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        /* password field*/ TextFormField(
                          onFieldSubmitted: (String value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userData(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              print(emailController.text);
                              print(passwordController.text);
                            }
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'too short';
                            }
                          },
                          controller: passwordController,
                          obscureText: pass,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ShopCubit.get(context).showPass();
                              },
                              icon: Icon(cubit.suffixicon),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          height: 40.0,
                          color: Colors.blue,
                          child: state is! ShopLoginScreenLoadingState
                              ? TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userData(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                      print(emailController.text);
                                      print(passwordController.text);
                                    }
                                  },
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.deepOrange,
                                )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ShopRegisterScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Register Now',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is ShopLoginScreenSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CachHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) => {
                    token = state.loginModel.data!.token!,
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeLayout(),
                      ),
                    ),
                  });

              showToast(
                  text: '${state.loginModel.message}',
                  state: ToastStates.SUCCESS);
            } else {
              print(state.loginModel.message);
              showToast(
                  text: '${state.loginModel.message}',
                  state: ToastStates.ERROR);
            }
          }
        },
      ),
    );
  }
}
