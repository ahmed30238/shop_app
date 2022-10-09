import 'package:flutter/material.dart';
import 'package:flutter_application_1/register_screen/shop_app_register_cubit/cubit.dart';
import 'package:flutter_application_1/register_screen/shop_app_register_cubit/states.dart';
import 'package:flutter_application_1/screens/layout/home.dart';
import 'package:flutter_application_1/screens/login_screen/loginscreen.dart';
import 'package:flutter_application_1/shared/component/components/shared.dart';
import 'package:flutter_application_1/shared/network/local/sharedpref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterScreenSuccessState) {
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
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);

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
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Register now to browse our hot offers',
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
                          controller: nameController,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
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
                        defaultTextFormField(
                          controller: phoneController,
                          text: 'Phone',
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'too short';
                            }
                          },
                          prefix: Icons.phone,
                          isPass: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'too short';
                            }
                          },
                          controller: passwordController,
                          obscureText: cubit.isShown,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ShopRegisterCubit.get(context).showPass();
                              },
                              icon: Icon(
                                cubit.isShown
                                    ? Icons.visibility
                                    : Icons.visibility_off_sharp,
                              ),
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
                          child: state is! ShopRegisterScreenLoadingState
                              ? TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userData(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : const Center(
                                  child: Center(
                                    child: CircularProgressIndicator(color: Colors.white,),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShopLoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Login Now',
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
      ),
    );
  }
}
